{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1,1920x1080,0x0,auto"
    ];
  };
}