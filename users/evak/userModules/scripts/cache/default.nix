{ config, pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "push-cache"
      (builtins.readFile ./push-cache.sh))
  ];
}
