{ config, pkgs, ... }:
{
  home.packages = [
    # (pkgs.writeShellScriptBin "deploy-host" 
    #   (builtins.readFile ./deploy-host.sh))
    (pkgs.writeShellScriptBin "bootstrap-host" 
      (builtins.readFile ./bootstrap-host.sh))
  ];
}