{ config, lib, pkgs, ... }:

with lib;

{
  # Define an option for the script path
  options = {
    receiptScanner.enable = lib.mkEnableOption "Receipt Scanner utility"
  };

  # Define the activation of the module
  config = lib.mkIf config.receiptScanner.enable {
    # Enable the script if the path is provided
    environment.systemPackages = (pkgs.writeShellScriptBin "scan-receipt" ./scan-receipt.bash);
  };
}
