{ config, pkgs, ... }: 
let 
  checkHost = pkgs.writeShellScriptBin "check-host" ''
    #!/usr/bin/env bash
    IP_ADDRESS="$1"
    SSH_PORT="''${2:-22}"

    # Ping the host silently with a 1-second timeout
    if ! ping -c 1 -W 1 "$IP_ADDRESS" &> /dev/null; then
        exit 1
    fi

    # Check if there is an existing host key in known_hosts
    HOST_PATTERN=$(ssh-keygen -F "$IP_ADDRESS" 2>/dev/null)

    if [[ -z "$HOST_PATTERN" ]]; then
        # No stored host key, return 0 as per your requirements
        exit 0
    fi

    # Retrieve the current host key
    CURRENT_HOST_KEY=$(ssh-keyscan -p "$SSH_PORT" "$IP_ADDRESS" 2>/dev/null)

    if [[ -z "$CURRENT_HOST_KEY" ]]; then
        # Could not retrieve host key, return non-zero
        exit 1
    fi

    # Compare the retrieved host key against the stored one
    if ssh-keygen -F "$IP_ADDRESS" | grep -Fq "$CURRENT_HOST_KEY"; then
        exit 0
    else
        exit 1
    fi
  '';
in {
  home.packages = with pkgs; [
    totp-port-knockd-rs
  ];

  programs.ssh = {
    enable = true;

    matchBlocks = {
      #######################################################################
      # Servers
      #######################################################################
      "router" = {
        hostname = "192.168.1.1";
        user = "root";
        identityFile = "~/.ssh/ddwrt";
        extraOptions = {
          "HostKeyAlgorithms" = "+ssh-rsa";
        };
      };

      "key_server" = {
        hostname = "192.168.1.3";
        user = "service";
        identityFile = "~/.ssh/key_server";
      };

      "pxe_server" = {
        hostname = "192.168.1.5";
        user = "service";
        identityFile = "~/.ssh/pxe_server";
      };

      "homeserver1-local" = {
        match = "host homeserver1 exec \"${checkHost}/bin/check-host 192.168.1.8\"";
        hostname = "192.168.1.8";
      };

      "homeserver1-remote" = {
        host = "homeserver1";
        hostname = "10.100.0.2";
        user = "service";
        identityFile = "~/.ssh/homeserver1";
      };

      #######################################################################
      # Pifarm
      #######################################################################
      "pifarm1" = {
        hostname = "192.168.1.16";
        user = "ubuntu";
        identityFile = "~/.ssh/pifarm1";
      };

      "pifarm2" = {
        hostname = "192.168.1.17";
        user = "ubuntu";
        identityFile = "~/.ssh/pifarm2";
      };

      "pifarm3" = {
        hostname = "192.168.1.18";
        user = "ubuntu";
        identityFile = "~/.ssh/pifarm3";
      };

      "pifarm4" = {
        hostname = "192.168.1.19";
        user = "gardener";
        identityFile = "~/.ssh/pifarm";
      };


      #######################################################################
      # Personal Computers
      #######################################################################
      "laptop" = {
        hostname = "192.168.1.64";
        user = "evak";
        identityFile = "~/.ssh/laptop";
      };

      "workstation" = {
        hostname = "192.168.1.32";
        user = "evak";
        identityFile = "~/.ssh/workstation";
      };

      #######################################################################
      # Kiosks
      #######################################################################
      "media_kiosk" = {
        hostname = "192.168.1.96";
        user = "service";
        identityFile = "~/.ssh/media_kiosk";
      };

      #######################################################################
      # Mobile Devices
      #######################################################################
      "pinetab" = {
        hostname = "192.168.1.139"; # Temporary
        user = "nixos";
        identityFile = "~/.ssh/pinetab";
      };

      "pixel_4g" = {
        hostname = "192.168.1.149";
        user = "u0_a192";
        port = 8022;
        identityFile = "~/.ssh/pixel_4g";
      };

      #######################################################################
      # Virtual Machines
      #######################################################################
      "qemu-vm" = {
        hostname = "0.0.0.0";
        port = 2222;
        user = "galahad";
        identityFile = "~/.ssh/qemu_vm";
      };

      "test-vm" =
        let
          hostIp = "192.168.1.136";
          knocker = "${pkgs.totp-port-knockd-rs}/bin/totp-knocker";
        in
        {
          match = "host test-vm exec \"${knocker} ${hostIp} > /tmp/totp-knock.log\"";
          hostname = "${hostIp}";
          user = "tester";
          identityFile = "~/.ssh/test_vm";
          extraOptions = {
            "StrictHostKeyChecking" = "no";
            "CheckHostIP" = "no";
          };
        };

      #######################################################################
      # Virtual Private Servers
      #######################################################################
      "bastion0" = {
        hostname = "45.33.8.38";
        user = "service";
        identityFile = "~/.ssh/bastion0";
      };

      #######################################################################
      # Live Installers
      #######################################################################
      "installer" = {
        hostname = "192.168.1.8";
        user = "service";
        identityFile = "~/.ssh/installer";
        extraOptions = {
          "StrictHostKeyChecking" = "no";
          "CheckHostIP" = "no";
        };
      };

      #######################################################################
      # Version Control Systems
      #######################################################################
      "github.com" = {
        identityFile = "~/.ssh/github";
      };

      "gitea.chiliahedron.wtf-local" = {
        match = "host gitea.chiliahedron.wtf exec \"${checkHost}/bin/check-host 192.168.1.8\"";
        hostname = "192.168.1.8";
      };

      "gitea.chiliahedron.wtf-remote" = {
        host = "gitea.chiliahedron.wtf";
        hostname = "10.100.0.2";
        port = 6022;
        identityFile = "~/.ssh/gitea";
      };

      "aur.archlinux.org" = {
        user = "aur";
        identityFile = "~/.ssh/aur";
      };
    };
  };
}
