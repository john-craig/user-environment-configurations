{ config, pkgs, lib, ... }:
let
in {
  panmuphle = {
    globalDefaultScreen = "MAIN_MONITOR";

    screens = [
      {
        name = "eDP-1";
        alias = "MAIN_MONITOR";
      }
    ];

    # Laptop only has one screen, no need to configure this
    workspaceScreens = { };
  };
}
