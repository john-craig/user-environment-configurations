{ config, pkgs, ... }:
{
  home.file = {
    ".config/dismas/overlays".source = ./overlays;
  };
}