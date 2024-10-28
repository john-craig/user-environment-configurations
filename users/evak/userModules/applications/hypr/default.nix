{ config, pkgs, ... }:
{
  home.file = {
    ".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
    ".config/hypr/hyprland.conf".source = ./hyprland.conf;
  };
}