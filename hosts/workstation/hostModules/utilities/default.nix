{ config, pkgs, ... }:
{
  imports = [
    ./receiptScanner
    ./labelPrinter
  ];
}
