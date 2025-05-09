{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # hyprland
    # hypridle
    # hyprpaper
    # hyprlock
    # hyprcursor

    nixgl.auto.nixGLDefault
    nixgl.auto.nixGLNvidia
  ];

  # home.sessionVariables = {
  #   LIBGL_DRIVERS_PATH = "/usr/lib/dri";
  #   GBM_BACKENDS_PATH = "/usr/lib/gbm";
  # };

  # wayland.windowManager.hyprland.enable = true; # enable Hyprland

  home.file = {
    ".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    ".config/hypr/hyprland.conf".source = ./hyprland.conf;
    # ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
    # ".config/hypr/hypridle.conf".source = ./hypridle.conf;
  };
}
