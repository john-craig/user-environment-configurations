{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "HDMI-A-1,1920x1080,1920x0,auto"
      "DP-1,1920x1080,0x0,auto"
    ];
  };
}