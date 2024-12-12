{ config, pkgs, ... }:
{
  home.file = {
    ".config/BetterDiscord/themes/DarkNeon.theme.css".source = ./DarkNeon.theme.css;
  };
}
