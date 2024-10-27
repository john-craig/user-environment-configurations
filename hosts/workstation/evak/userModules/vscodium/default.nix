{ config, pkgs, ... }:
{
  home.file = {
    ".config/VSCodium/User/keybindings.json".source = ./keybindings.json;
    ".config/VSCodium/User/settings.json".source = ./settings.json;
  };
}