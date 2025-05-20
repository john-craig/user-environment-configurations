{ config, pkgs, ... }:
{
  imports = [
    ./hostModules
  ];

  services.networkStatusMonitor = 
    let 
      checkLAN = pkgs.writeShellScriptBin "check-local-area-network" ''
        #!/usr/bin/env bash
        IP_ADDRESS="192.168.1.1"
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
      enable = true;
      checkInternalNetwork = "${checkLAN}/bin/check-local-area-network";
      internalNetworkScripts = [  ];
      externalNetworkScripts = [  ];
  };
}
