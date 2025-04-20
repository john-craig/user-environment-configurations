{ config, pkgs, lib, ... }: let 
in {
  panmuphle = {
    screens = [
      {
        name = "eDP-1";
        alias = "MAIN_MONITOR";
      }
    ];

    workspaceScreens = [
        {
          # browsing
          default_screen = "MAIN_MONITOR";
          windows = [
            {
              preferred_screen = "MAIN_MONITOR";
            }
          ];
        }
        {
          # studying
          default_screen = "MAIN_MONITOR";
          windows = [
            {
              preferred_screen = "MAIN_MONITOR";
            }
          ];
        }
        {
          # social
          default_screen = "MAIN_MONITOR";
          windows = [
            {
              preferred_screen = "MAIN_MONITOR";
            }
          ];
        }
        {
          # development
          default_screen = "MAIN_MONITOR";
          windows = [
            {
              preferred_screen = "MAIN_MONITOR";
            }
          ];
        }
        {
          # office
          default_screen = "MAIN_MONITOR";
          windows = [
            {
              preferred_screen = "MAIN_MONITOR";
            }
          ];
        }
      ];
  };
}
