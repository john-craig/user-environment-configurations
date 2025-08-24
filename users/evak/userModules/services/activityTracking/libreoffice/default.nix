{ config, pkgs, lib, ... }: {
  home.packages = [
    pkgs.lsof
  ];
}
