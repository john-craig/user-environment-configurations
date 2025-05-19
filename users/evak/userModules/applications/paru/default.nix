{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    paru
  ];

  programs.zsh.shellAliases = {
    paru = "__DISMAS_CALLER=Y paru";
  };
}
