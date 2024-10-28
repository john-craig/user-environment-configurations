{ config, pkgs, ... }:
{
  imports = [
    ./path
    ./variables
    ./plugins
  ];

  programs.zsh = {
      enable = true;
  };
}
