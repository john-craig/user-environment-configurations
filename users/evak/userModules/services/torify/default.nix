{ config, pkgs, ... }:
{
  home.packages = [ pkgs.tor pkgs.coreutils ];

  home.file.".config/tor-proxy.pac".text = let
    # Define your Tor-routed domains here
    torDomains = [
      "psb62860.seedbox.io"
      "check.torproject.org"
    ];

    # Convert Nix list of domains into JavaScript array syntax
    torDomainsJs = pkgs.lib.concatStringsSep ",\n  " (map (d: "\"${d}\"") torDomains);
  in ''
    function FindProxyForURL(url, host) {
      var torDomains = [
        ${torDomainsJs}
      ];
      for (var i = 0; i < torDomains.length; i++) {
        if (dnsDomainIs(host, torDomains[i])) {
          return "SOCKS5 127.0.0.1:9050";
        }
      }
      return "DIRECT";
    }
  '';

  programs.chromium.commandLineArgs = let
    pacPath = "${config.home.homeDirectory}/.config/tor-proxy.pac";
    pacDataURI = "'data:application/x-javascript-config;base64,'$(${pkgs.coreutils}/bin/base64 -w0 ${pacPath})";
  in [
    "--proxy-pac-url=${pacDataURI}"
  ];

  # Systemd user service for Tor SOCKS proxy
  systemd.user.services.tor = {
    Unit.Description = "Tor SOCKS proxy";
    Service = {
      ExecStart = "${pkgs.tor}/bin/tor --SocksPort 9050";
      Restart = "always";
    };
    Install.WantedBy = [ "default.target" ];
  };

}
