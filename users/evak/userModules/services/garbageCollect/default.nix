{ config, pkgs, ... }: {
  systemd.user.services.nixCollectGarbage = {
    Unit = {
      Description = "Daily nix-collect-garbage -d";
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.nix}/bin/nix-collect-garbage -d";
    };
  };

  systemd.user.timers.nixCollectGarbage = {
    Unit = {
      Description = "Run nix-collect-garbage -d daily";
    };

    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
