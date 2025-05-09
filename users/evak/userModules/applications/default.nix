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
    ./panmuphle
    ./dismas
    ./keepassxc
    ./gtk
    ./rofi
    ./discord
    ./vscodium
    ./ungoogled-chromium
    ./openssh
  ];
}
