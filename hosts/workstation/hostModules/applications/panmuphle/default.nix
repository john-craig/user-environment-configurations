{ config, pkgs, ... }:
{
  home.file = {
    ".panmuphled.json".source = ./panmuphled.json;
  };
}