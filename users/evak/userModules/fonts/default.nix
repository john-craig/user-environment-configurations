{ config, pkgs, ... }:
{
  home.packages = [
    # Fonts
    pkgs.font-awesome
  ];

  fonts.fontconfig.enable = true;
}