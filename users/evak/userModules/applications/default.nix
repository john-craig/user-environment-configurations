{ config, pkgs, ... }:
{
  imports = [
    ./alucard
    ./git
    ./paru
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
