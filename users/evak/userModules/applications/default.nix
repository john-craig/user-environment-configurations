{ config, pkgs, ... }:
{
  imports = [
    ./nix
    ./user-dirs
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