{ config, pkgs, ... }:
{
  imports = [
    ./homelab
    ./user-environment
    ./cache
  ];
}
