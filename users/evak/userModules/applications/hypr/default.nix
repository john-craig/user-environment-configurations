{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # hyprland
    # hypridle
    # hyprpaper
    # hyprlock
    # hyprcursor

    # wezterm
    # waybar
    # hyprpaper
    # hyprshot

    nixgl.auto.nixGLDefault
    nixgl.auto.nixGLNvidia
    # glxinfo
  ];

  wayland.windowManager = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        "$terminal" = "wezterm";
        "$panmuphlectl" = "~/.nix-profile/bin/panmuphlectl";
        "$faustrollctl" = "~/.nix-profile/bin/faustrollctl";
        "$mainMod" = "SUPER";

        monitor = [
          "DP-1,1920x1080,1920x0,auto"
          "HDMI-A-1,1920x1080,0x0,auto"
        ];

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
          "XDG_SESSION_TYPE,wayland"
          # "AQ_DRM_DEVICES,/dev/dri/card2"
        ];

        exec-once = [
          "waybar & hyprpaper"
          "sleep 2 && ~/.nix-profile/bin/panmuphled --conf ~/.panmuphled.json"
        ];

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad = {
            natural_scroll = false;
          };
        };

        gestures.workspace_swipe = false;

        device = [{
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }];

        cursor.no_hardware_cursors = true;

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(f715abee) rgba(34edf3ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 10;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
          bezier = ["myBezier, 0.05, 0.9,  0.1,  1.05"];
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, myBezier"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master.new_status = "master";

        misc = {
          force_default_wallpaper = -1;
          disable_hyprland_logo = false;
        };

        bind = [
          "$mainMod, RETURN, exec, wezterm"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, $menu"
          "$mainMod, P, pseudo,"
          "$mainMod, J, togglesplit,"
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"
          "$mainMod, SPACE, exec, $panmuphlectl select-window"
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
          "$mainMod, F12, exec, hyprshot -m window"
          "$mainMod SHIFT, F12, exec, hyprshot -m region"
          "$mainMod ALT, SPACE, exec, $panmuphlectl select-workspace"
          "$mainMod ALT, EQUAL, exec, $panmuphlectl launch-workspace"
          "$mainMod ALT, MINUS, exec, $panmuphlectl close-workspace"
          "$mainMod ALT, 1, exec, $panmuphlectl switch-workspace --index 1"
          "$mainMod ALT, 2, exec, $panmuphlectl switch-workspace --index 2"
          "$mainMod ALT, 3, exec, $panmuphlectl switch-workspace --index 3"
          "$mainMod ALT, 4, exec, $panmuphlectl switch-workspace --index 4"
          "$mainMod ALT, 5, exec, $panmuphlectl switch-workspace --index 5"
          "$mainMod ALT, 6, exec, $panmuphlectl switch-workspace --index 6"
          "$mainMod ALT, 7, exec, $panmuphlectl switch-workspace --index 7"
          "$mainMod ALT, 8, exec, $panmuphlectl switch-workspace --index 8"
          "$mainMod ALT, 9, exec, $panmuphlectl switch-workspace --index 9"
          "$mainMod ALT, 0, exec, $panmuphlectl switch-workspace --index 10"
          "$mainMod ALT, up, exec, $panmuphlectl switch-workspace --direction UP"
          "$mainMod ALT, down, exec, $panmuphlectl switch-workspace --direction DOWN"
          "$mainMod ALT SHIFT, left, exec, $panmuphlectl move-window --screen LEFT_MONITOR"
          "$mainMod ALT SHIFT, right, exec, $panmuphlectl move-window --screen RIGHT_MONITOR"
          "$mainMod ALT, r, exec, $panmuphlectl suspend && ~/.nix-profile/bin/panmuphled --conf ~/.panmuphled.json --restore"
          "$mainMod ALT SHIFT, r, exec, $panmuphlectl terminate || ~/.nix-profile/bin/panmuphled --conf ~/.panmuphled.json"
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          "$mainMod, mouse:272, movewindow"
          # "$mainMod, mouse:273, resizewindow"
          "$mainMod SHIFT, RETURN, exec, $faustrollctl create-date-entry"
          "$mainMod SHIFT, N, exec, $faustrollctl create-project-task"
          "$mainMod SHIFT, M, exec, $faustrollctl modify-project-task"
          "$mainMod SHIFT, D, exec, $faustrollctl remove-project-task"
        ];

        windowrulev2 = [
          "float,initialTitle:^(Open File)$"
          "float,initialTitle:^(Open Folder)$"
          "float,initialTitle:^(Save File)$"
          "suppressevent maximize, class:.*"
        ];
      };
    };

    
  };

  home.sessionVariables = {
    XCURSOR_SIZE = "24";
    HYPRCURSOR_SIZE = "24";
    # GBM_BACKENDS_PATH = "/usr/lib/gbm";
    # LIBGL_DRIVERS_PATH = "/usr/lib/gbm";
    # XDG_SESSION_TYPE = "wayland";
    # WLR_DRM_DEVICES = "/dev/dri/card2";
  };
  # home.sessionVariables = {
  # };

  home.file = {
    ".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    # ".config/hypr/hyprland.conf".source = ./hyprland.conf;
    ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
    # ".config/hypr/hypridle.conf".source = ./hypridle.conf;
  };
}
