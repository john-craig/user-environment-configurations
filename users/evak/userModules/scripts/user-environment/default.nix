{ config, pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "add-config"
      (builtins.readFile ./add-config.sh))
    # (pkgs.writeShellScriptBin "deploy-user" 
    #   (builtins.readFile ./deploy-user.sh))
  ];
}
