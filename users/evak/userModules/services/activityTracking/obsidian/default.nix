{ config, pkgs, lib, ... }: let 
  vaultPath = "${config.home.homeDirectory}/documents/by_category/vault";
  obsidianWatchFile = "${vaultPath}/.obsidian/workspace.json";
in  {
  home.packages = [
    (pkgs.writeShellScriptBin "current-file-obsidian"
      (builtins.readFile ./current-file-obsidian.sh))
  ];

  systemd.user.services.obsidian-file-watcher = {
    Unit = {
      Description = "Run script when a file changes";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/echo File changed! >> $HOME/file-watcher.log'";
    };
  };

  # systemd.user.paths.obsidian-file-watcher = {
  #   Unit = {
  #     Description = "Watch a file for changes";
  #   };
  #   Path = {
  #     PathChanged = "${obsidianWatchFile}";
  #   };
  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  # };
}
