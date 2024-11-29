{ config, pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "build-image" 
      (builtins.readFile ./build-image.sh))
    (pkgs.writeShellScriptBin "install-image" 
      (builtins.readFile ./install-image.sh))
  ];
}