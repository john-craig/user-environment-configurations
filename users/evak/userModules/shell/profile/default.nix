{ config, pkgs, ... }:
{
  home.file.".zprofile".source = ./zprofile.zsh;
}