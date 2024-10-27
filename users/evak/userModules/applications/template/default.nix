{ config, pkgs, ... }:
{
  home.file = {
    ".config/example.conf".source = ./example.conf;
  };
}