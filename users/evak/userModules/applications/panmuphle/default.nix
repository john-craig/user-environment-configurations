{ config, pkgs, ... }:
{
  imports = [ ./module.nix ];

  config = {
    home.packages = with pkgs; [
      panmuphle
      vscodium
      nyxt
      libreoffice
      obsidian
      # godot_4
      # davinci-resolve
    ];

    panmuphle = {
      enable = true;

      initial_workspaces = [
        "browsing"
        "studying"
      ];

      workspaces = [
        {
          "name" = "browsing";
          "windows" = [
            {
              "displayed_default" = true;
              "applications" = [
                {
                  "name" = "chromium";
                  "exec" = "${pkgs.ungoogled-chromium}/bin/chromium";
                  "focused_default" = true;
                }
              ];
            }
          ];
        }
        {
          "name" = "studying";
          "windows" = [
            {
              "displayed_default" = true;
              "applications" = [
                {
                  "name" = "obsidian";
                  "exec" = "${pkgs.obsidian}/bin/obsidian --ozone-platform=wayland --disable-gpu";
                  "focused_default" = true;
                }
              ];
            }
          ];
        }
        {
          "name" = "social";
          "windows" = [
            {
              "displayed_default" = true;
              "applications" = [
                {
                  "name" = "discord";
                  "exec" = "/usr/bin/discord --ozone-platform=wayland --disable-gpu";
                  "focused_default" = true;
                }
              ];
            }
          ];
        }
        {
          "name" = "development";
          "windows" = [
            {
              "displayed_default" = true;
              "applications" = [
                {
                  "name" = "code";
                  "exec" = "${pkgs.vscodium}/bin/codium --ozone-platform-hint=wayland --disable-gpu";
                  "focused_default" = true;
                }
              ];
            }
            # {
            #   "displayed_default" = false;
            #   "applications" = [
            #     {
            #       "name" = "nyxt";
            #       "exec" = "/usr/bin/nyxt --no-socket";
            #       "focused_default" = false;
            #     }
            #   ];
            # }
          ];
        }
        {
          "name" = "office";
          "windows" = [
            {
              "displayed_default" = true;
              "applications" = [
                {
                  "name" = "libreoffice";
                  "exec" = "${pkgs.libreoffice}/bin/libreoffice";
                  "focused_default" = true;
                }
              ];
            }
          ];
        }
      ];
    };
  };
}