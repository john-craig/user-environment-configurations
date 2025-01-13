{ config, pkgs, ... }:
{

  programs.zsh = {
    plugins = [
      {
        name = "notify";
        src = ./notify;
      }
    ];
  };
}
