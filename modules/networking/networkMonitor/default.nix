{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.networkStatusMonitor;
  userScripts = {
    checkInternalNetwork = cfg.checkInternalNetwork;
    offlineNetworkScripts = cfg.offlineNetworkScripts;
    internalNetworkScripts = cfg.internalNetworkScripts;
    externalNetworkScripts = cfg.externalNetworkScripts;
  };
  offlineScripts = lib.concatStringsSep " " userScripts.offlineNetworkScripts;
  localScripts = lib.concatStringsSep " " userScripts.internalNetworkScripts;
  externalScripts = lib.concatStringsSep " " userScripts.externalNetworkScripts;

  checkOnlineNetwork = ''
    ping -c 1 -q archlinux.org >&/dev/null
  '';
  monitorScript = pkgs.writeShellScriptBin "monitor-script" ''
    ${checkOnlineNetwork}
    if [ $? -eq 0 ]; then
      for script in ${offlineScripts}; do
        $script;
      done;
      exit 0
    fi

    ${userScripts.checkInternalNetwork}
    if [ $? -eq 0 ]; then
      echo "Executing scripts for internal network"
      for script in ${localScripts}; do
        $script;
      done;
    else
      echo "Executing scripts for external network"
      for script in ${externalScripts}; do
        $script;
      done;
    fi
  '';
in {
  options.services.networkStatusMonitor = {
    enable = mkEnableOption "Network status-based script executor";

    checkInternalNetwork = mkOption {
      type = types.path;
      description = "Script that determines if we're on the home network (exit 0=yes, 1=no)";
    };

    offlineNetworkScripts = mkOption {
      type = with types; listOf path;
      default = [];
      description = "Scripts to run when offline.";
    };

    internalNetworkScripts = mkOption {
      type = with types; listOf path;
      default = [];
      description = "Scripts to run when on internal network.";
    };

    externalNetworkScripts = mkOption {
      type = with types; listOf path;
      default = [];
      description = "Scripts to run when on an external network.";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.networkStatusMonitor = {
      Unit = {
        Description = "Network Status Monitor";
        Wants = [ "network-online.target" ];
        After = [ "network-online.target" ];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${monitorScript}/bin/monitor-script";
        RemainAfterExit = true;
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
} 
