{ config, pkgs, lib, ... }: {
  imports = [
    # ./hyprland
    # ./libreoffice
    ./obsidian
    # ./vscodium
  ];

  home.packages = [
    (pkgs.writeShellScriptBin "activity-tracker-record" ''
      ACTIVITY_TIME=$(date +%s)
      ACTIVITY_CATEGORY=$1
      
    '') 
  ];

}
