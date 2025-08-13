{ config, pkgs, lib, ... }:
let
in {
  panmuphle = {
    globalDefaultScreen = "RIGHT_MONITOR";

    screens = [
      {
        name = "DP-1";
        alias = "RIGHT_MONITOR";
      }
      {
        name = "HDMI-A-1";
        alias = "LEFT_MONITOR";
      }
    ];

    workspaces = lib.mkAfter [
      {
        name = "gaming:feed-the-beast";
        windows = [
          {
            displayed_default = true;
            applications = [
              {
                name = "feed-the-beast";
                exec = "/usr/bin/ftb-app";
                focused_default = true;
              }
            ];
          }
        ];
      }
      {
        name = "streaming";
        windows = [
          {
            displayed_default = true;
            applications = [
              {
                name = "obs-studio";
                exec = "obs";
                focused_default = true;
              }
            ];
          }
        ];
      }
    ];

    workspaceScreens = {
      "browsing" = {
        default_screen = "RIGHT_MONITOR";
        windows."0".preferred_screen = "LEFT_MONITOR";
      };
      "studying" = {
        default_screen = "LEFT_MONITOR";
        windows."0".preferred_screen = "RIGHT_MONITOR";
      };
      "social" = {
        default_screen = "RIGHT_MONITOR";
        windows."0".preferred_screen = "LEFT_MONITOR";
      };
      "development" = {
        default_screen = "RIGHT_MONITOR";
        windows."0".preferred_screen = "LEFT_MONITOR";
      };
      "streaming" = {
        default_screen = "LEFT_MONITOR";
        windows."0".preferred_screen = "RIGHT_MONITOR";
      };
      "gaming:feed-the-beast" = {
        default_screen = "LEFT_MONITOR";
        windows."0".preferred_screen = "RIGHT_MONITOR";
      };
    };
  };
}
