{ config, pkgs, ... }:
{
  imports = [
    ./hypr
    ./wezterm
    ./waybar
    ./pipewire
    ./keepassxc
    ./gtk
    ./better-discord
    ./rofi
    ./discord
    ./vscodium
  ];
}