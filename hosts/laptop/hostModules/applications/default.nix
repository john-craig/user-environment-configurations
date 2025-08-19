{ config, pkgs, ... }:
{
  imports = [
    ./panmuphle
    ./openssh
    ./hypr
  ];
}
