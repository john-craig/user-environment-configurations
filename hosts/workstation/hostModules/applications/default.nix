{ config, pkgs, ... }:
{
  imports = [
    ./panmuphle
    # ./pipewire
    ./nix
    ./obs-studio
  ];
}
