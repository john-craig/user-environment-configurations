{ config, pkgs, lib, ... }:
{
  home.sessionVariables = let 
    paths = [
      "$HOME/.nix-profile/bin"
      "$HOME/.pyenv/bin"
      "/opt/android-sdk/cmdline-tools/latest/bin"
    ];
  in  {
    PATH = builtins.concatStringsSep ":" (["$PATH"] ++ paths);
  };
}
