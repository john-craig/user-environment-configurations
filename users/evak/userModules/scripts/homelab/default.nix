{ config, pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "deploy-host" 
      (builtins.readFile ./deploy-host.sh))
  ];
}