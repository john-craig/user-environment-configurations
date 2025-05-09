{ config, pkgs, ... }:
{
  home.packages = [
    # Fonts
    pkgs.font-awesome
    pkgs.noto-fonts-emoji
    pkgs.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;
}
