{ config, pkgs, ... }:
{
  imports = [
    ./homelab
    ./user-environment
    ./disk-images
    ./cache
  ];
}
