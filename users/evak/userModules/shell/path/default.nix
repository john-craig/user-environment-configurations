{ config, pkgs, lib, ... }:
let 
    paths = [
      "$HOME/.nix-profile/bin"
      "$HOME/.pyenv/bin"
      "/opt/android-sdk/cmdline-tools/latest/bin"
    ];
in {
  home.sessionVariables = {
    PATH = builtins.concatStringsSep ":" (paths ++ ["$PATH"]);
  };

  # Scrape all that nonsense off the front of our PATH
  programs.zsh.initExtra = ''
    PATH="${builtins.elemAt paths 0}''${PATH#*${builtins.elemAt paths 0}}"
  '';
}
