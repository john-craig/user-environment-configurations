{ config, pkgs, ... }:
{
  imports = [
    ./completions
    ./path
    ./plugins
    ./variables
  ];

  programs.zsh = {
    enable = true;
  };
}
