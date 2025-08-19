{ config, pkgs, ... }:
let
  activeBorderColor = "rgba(f715abee) rgba(34edf3ee) 45deg";
in {
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
    # wprintidle

    nixgl.auto.nixGLDefault
    # nixgl.auto.nixGLNvidia
  ];

  home.sessionVariables = {
    LIBSEAT_BACKEND = "logind";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_SIZE = "24";
    # AQ_DRM_DEVICES = "/dev/dri/card1";

    LIBGL_DRIVERS_PATH = "/usr/lib/dri";
    GBM_BACKENDS_PATH = "/usr/lib/gbm";
    XDG_SESSION_TYPE = "wayland";
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

        # debug = {
        #   disable_logs = false;
        #   enable_stdout_logs = true;
        # };

        monitor = [ ];

        env = [ ];

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
          "col.active_border" = "${activeBorderColor}";
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
          preserve_split = true;
          pseudotile = true;
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
          "$mainMod ALT, RETURN, exec, wezterm start --class org.wezfurlong.wezterm.floating"
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

          "float,center,pinned,class:.*[Ff]loat.*"

          "suppressevent maximize, class:.*"
        ];
      };
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        "lock_cmd" = "/usr/bin/hyprlock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "/usr/bin/hyprlock";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      "$font" = "Monospace";

      general = {
        hide_cursor = false;
      };

      /*
      auth.fingerprint = {
        enabled = true;
        ready_message = "Scan fingerprint to unlock";
        present_message = "Scanning...";
        retry_delay = 250;
      };
      */

      animations = {
        enabled = true;
        bezier = "linear, 1, 1, 0, 0";
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
          "inputFieldDots, 1, 2, linear"
        ];
      };

      background = {
        monitor = "";
        path = "screenshot";
        blur_passes = 3;
      };

      input-field = {
        monitor = "";
        size = "20%, 5%";
        outline_thickness = 3;
        inner_color = "rgba(0, 0, 0, 0.0)";

        outer_color = "${activeBorderColor}";
        check_color = "rgba(00ff99ee) rgba(ff6633ee) 120deg";
        fail_color = "rgba(ff6633ee) rgba(ff0066ee) 40deg";

        font_color = "rgb(143, 143, 143)";
        fade_on_empty = false;
        rounding = 15;

        font_family = "$font";
        placeholder_text = "Input password...";
        fail_text = "$PAMFAIL";

        # Optional settings (commented)
        # dots_text_format = "*";
        # dots_size = 0.4;
        dots_spacing = 0.3;

        # hide_input = true;

        position = "0, -20";
        halign = "center";
        valign = "center";
      };
    };
  };

  home.file = {
    ".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    # ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
    # ".config/hypr/hypridle.conf".source = ./hypridle.conf;
  };
}
