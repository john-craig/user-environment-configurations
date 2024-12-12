{ config, pkgs, ... }:
{
  home.file = {
    ".config/rofi/80sneon.rasi".source = ./80sneon.rasi;
    ".config/rofi/config.rasi".source = ./config.rasi;
  };
}
