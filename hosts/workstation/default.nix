{ config, pkgs, ... }:
{
  imports = [
    ./hostModules/applications
    ./hostModules/utilities
  ];

  receiptScanner.enable = true;
}
