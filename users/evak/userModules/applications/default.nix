{ config, pkgs, ... }:
{
  imports = [
    ./alucard
    ./git
    ./nix
    ./nyxt
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
    ./openssh
  ];
}
