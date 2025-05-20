{ config, pkgs, lib, ... }: 
let 
  mkDynamicSshConfScript = title: confSrc: confDest:
    pkgs.writeShellScriptBin "${title}" ''
      rm -f ${confDest}
      ln -s ${confSrc} ${confDest}
    '';

  mkSshHost = hostname: hostUser: hostPort: ipAddress: identityFile:
  ''
    Host ${hostname}
      User ${hostUser}
      Port ${hostPort}
      HostName ${ipAddress}
      IdentityFile ${identityFile}
  '';

  mkSshHostInternal = hostConf:
    let
      port = if builtins.hasAttr "port" hostConf
        then hostConf.port
        else "22";
    in (mkSshHost 
      hostConf.hostname
      hostConf.user
      port
      hostConf.ipAddresses.internal
      hostConf.identityFile);
  
  mkSshHostExternal = hostConf:
    let
      port = if builtins.hasAttr "port" hostConf
        then hostConf.port
        else "22";
    in (mkSshHost 
      hostConf.hostname
      hostConf.user
      port
      hostConf.ipAddresses.internal
      hostConf.identityFile);

  dynamicSshConfPath  = ".ssh/hosts/dynamic";
  internalSshConfPath = ".ssh/hosts/internal";
  externalSshConfPath = ".ssh/hosts/external";

  symlinkInternal = mkDynamicSshConfScript 
    "symlink-internal" internalSshConfPath dynamicSshConfPath;
  symlinkExternal = mkDynamicSshConfScript 
    "symlink-external" externalSshConfPath dynamicSshConfPath;

  hostConfigs = [
    {
      hostname = "homeserver1";
      user = "service";
      ipAddresses = {
        internal = "192.168.1.8";
        external = "100.10.0.2";
      };
      identityFile = "~/.ssh/homeserver1";
    }
    {
      hostname = "gitea.chiliahedron.wtf";
      user = "service";
      ipAddresses = {
        internal = "192.168.1.8";
        external = "100.10.0.2";
      };
      port = "6022";
      identityFile = "~/.ssh/gitea";
    }
  ];
in {
  home.file = {
    "${internalSshConfPath}".text = (lib.concatStringsSep "\n"
      (builtins.map mkSshHostInternal hostConfigs));

    "${externalSshConfPath}".text = (lib.concatStringsSep "\n"
      (builtins.map mkSshHostExternal hostConfigs));
  };

  services.networkStatusMonitor = {
    internalNetworkScripts = [
      "${symlinkInternal}/bin/symlink-internal"
    ];
    externalNetworkScripts = [
      "${symlinkExternal}/bin/symlink-external"
    ];
  };

  programs.ssh = {
    enable = true;

    includes = [
      "${dynamicSshConfPath}"
    ];

    matchBlocks = lib.mkAfter {
      "homeserver1" = {};
      "gitea.chiliahedron.wtf" = {};
    };
  };
}
