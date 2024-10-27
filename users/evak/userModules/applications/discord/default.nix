{ config, pkgs, ... }:
{
  home.file = {
    ".config/discord/settings.json".source = ./settings.json;
  };
}