{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    nix-prefetch-git
    dismas
  ];

  home.sessionVariables = {
    DISMAS_VAULT_PATH = "$DOCUMENTS/by_category/vault";
    DISMAS_DEFAULT_REPO_OWNER = "john-craig";
    DISMAS_PACKAGES_REPO_PATH = "$NIXPKGS_APOCRYPHA";
  };
}
