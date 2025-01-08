{ config, pkgs, ... }:

{
  imports = [

  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "display";
  home.homeDirectory = "/home/display";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [

  ];

  home.sessionVariables = {
    PS1 = " 📻 ";
  };

  programs.zsh = {
    enable = true;
  };
}
