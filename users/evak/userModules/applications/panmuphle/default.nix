{ config, pkgs, ... }:
{
  imports = [ ./module.nix ];

  config = {
    home.packages = with pkgs; [
      panmuphle
      # vscodium
      # nyxt
      libreoffice
      obsidian

      nixgl.auto.nixGLDefault
      godot_4
      gimp
      # davinci-resolve
      
      # Not yet able to make JACK work with Nixpkgs Audacity
      # audacity
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
                  "exec" = "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${config.programs.chromium.package}/bin/chromium";
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
                  "exec" = "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${pkgs.obsidian}/bin/obsidian --ozone-platform=wayland --no-sandbox";
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
                  "exec" = "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${pkgs.discord}/bin/discord --ozone-platform=wayland --no-sandbox";
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
                  "exec" = "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${config.programs.vscode.package}/bin/codium --ozone-platform-hint=wayland --no-sandbox";
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
                  "exec" = "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${pkgs.godot_4}/bin/godot4 --display-driver wayland";
                  "focused_default" = true;
                }
              ];
            }
          ];
        }
        {
          "name" = "image-editing";
          "windows" = [
            {
              "displayed_default" = true;
              "applications" = [
                {
                  "name" = "gimp";
                  "exec" = "${pkgs.nixgl.auto.nixGLDefault}/bin/nixGL ${pkgs.gimp}/bin/gimp";
                  "focused_default" = true;
                }
              ];
            }
          ];
        }
        {
          "name" = "sound-editing";
          "windows" = [
            {
              "displayed_default" = true;
              "applications" = [
                {
                  "name" = "audacity";
                  "exec" = "/usr/bin/audacity";
                  "focused_default" = true;
                }
              ]
            }
          ];
        }
      ];
    };
  };
}
