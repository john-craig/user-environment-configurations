{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # hyprland
    # hypridle
    # hyprlock
    # hyprcursor
    # hyprpaper
    # hyprshot

    faustroll
    # wezterm
    # waybar

    nixgl.auto.nixGLDefault
    # nixgl.auto.nixGLNvidia
  ];

  home.sessionVariables = {
    LIBSEAT_BACKEND = "logind";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_SIZE = "24";
    AQ_DRM_DEVICES = "/dev/dri/card1";

    # LIBGL_DRIVERS_PATH = "/usr/lib/dri";
    # GBM_BACKENDS_PATH = "/usr/lib/gbm";
    # XDG_SESSION_TYPE = "wayland";
    # WLR_DRM_DEVICES = "/dev/dri/card2";
  };

  wayland.windowManager = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
      settings = {
        "$terminal" = "wezterm";
        "$panmuphled" = "${pkgs.panmuphle}/bin/panmuphled";
        "$panmuphlectl" = "${pkgs.panmuphle}/bin/panmuphlectl";
        "$faustrollctl" = "${pkgs.faustroll}/bin/faustrollctl";
        "$mainMod" = "SUPER";

        debug = {
          disable_logs = false;
          enable_stdout_logs = true;
        };

        monitor = [
          "DP-1,1920x1080,1920x0,auto"
          "HDMI-A-1,1920x1080,0x0,auto"
        ];

        env = [
          "XDG_SESSION_TYPE,wayland"

          "AQ_TRACE,1"
          "HYPRLAND_TRACE,1"
        ];

        exec-once = [
          "waybar"
          "hyprpaper"
          "sleep 1 && $panmuphled --conf ~/.panmuphled.json"
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

        bind = let 
          softRestartPanmuphled = pkgs.writeShellScriptBin "soft-restart-panmuphled" ''
            ${pkgs.panmuphle}/bin/panmuphlectl suspend
            ${pkgs.panmuphle}/bin/panmuphled --conf ~/.panmuphled.json --restore &
          '';
          hardRestartPanmuphled = pkgs.writeShellScriptBin "hard-restart-panmuphled" ''
            ${pkgs.panmuphle}/bin/panmuphlectl terminate
            ${pkgs.panmuphle}/bin/panmuphled --conf ~/.panmuphled.json &
          '';
        in [
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
          "$mainMod ALT, r, exec, ${softRestartPanmuphled}/bin/soft-restart-panmuphled"
          "$mainMod ALT SHIFT, r, exec, ${hardRestartPanmuphled}/bin/hard-restart-panmuphled"
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          "$mainMod, mouse:272, movewindow"
          "$mainMod SHIFT, RETURN, exec, $faustrollctl create-date-entry"
          "$mainMod SHIFT, N, exec, $faustrollctl create-project-task"
          "$mainMod SHIFT, M, exec, $faustrollctl modify-project-task"
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

  home.file = {
    ".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    # ".config/hypr/hyprland.conf".source = ./hyprland.conf;
    # ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
    # ".config/hypr/hypridle.conf".source = ./hypridle.conf;
  };
}
