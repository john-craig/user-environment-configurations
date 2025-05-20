{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./shell
      
      ./networking/networkMonitor
    ];
}
