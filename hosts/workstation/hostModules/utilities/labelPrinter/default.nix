{ config, lib, pkgs, ... }:

with lib;

{
  # Define an option for the script path
  options = {
    labelPrinter.enable = lib.mkEnableOption "Receipt Scanner utility";
  };

  # Define the activation of the module
  config = lib.mkIf config.labelPrinter.enable {
    # Enable the script if the path is provided
    home.packages = with pkgs; [ 
      qrencode
      jq
      (pkgs.writeShellScriptBin "print-label" ./print-label.bash) 
    ];
  };
}
