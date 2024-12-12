{ config, pkgs, ... }:
{
  home.file = {
    ".config/gtk-3.0/settings.ini".source = ./settings.ini;
  };
}
