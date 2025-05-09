{ config, pkgs, ... }:
{
  imports = [ ./module.nix ];

  config = {
    home.packages = with pkgs; [
      panmuphle
      # vscodium
      nyxt
      libreoffice
      obsidian

      nixgl.nixGLIntel
      godot_4
      # davinci-resolve
    ];

    panmuphle = {
      enable = true;

      initialWorkspaces = [
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
                  "exec" = "/home/evak/.nix-profile/bin/chromium";
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
                  "exec" = "${pkgs.obsidian}/bin/obsidian --ozone-platform=wayland --disable-gpu --no-sandbox";
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
                  "exec" = "/usr/bin/discord --ozone-platform=wayland --disable-gpu --no-sandbox";
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
                  "exec" = "${pkgs.vscodium}/bin/codium --ozone-platform-hint=wayland --disable-gpu --no-sandbox";
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
        {
          "name" = "game-development";
          "windows" = [
            {
              "displayed_default" = true;
              "applications" = [
                {
                  "name" = "godot";
                  "exec" = "${pkgs.nixgl.nixGLIntel}/bin/nixGLIntel ${pkgs.godot_4}/bin/godot4 --display-driver wayland";
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