{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    dismas
  ];
  
  home.sessionVariables = {
    DISMAS_VAULT_PATH = "$DOCUMENTS/by_category/vault";
    DISMAS_PACKAGES_REPO_PATH = "$NIXPKGS_APOCRYPHA";
  };
}