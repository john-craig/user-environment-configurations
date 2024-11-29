{ config, pkgs, ... }:
{
  imports = [
    ./git
    ./nix
    ./user-dirs
    ./hypr
    ./wezterm
    ./waybar
    # ./pipewire
    ./dismas
    ./keepassxc
    ./gtk
    ./better-discord
    ./rofi
    ./discord
    ./vscodium
    ./ungoogled-chromium
  ];
}