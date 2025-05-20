{ config, pkgs, ... }:
{
  imports = [
    ./applications/panmuphle
    ./applications/openssh
  ];
}
