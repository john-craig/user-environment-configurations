{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nixos-rebuild
    alucard
  ];

  home.file = {
    ".config/alucard/host-config.json".source = ./host-config.json;
  };

  programs.zsh.shellAliases = {
    "deploy-host" = "ALUCARD_OVERLAYS=\$(dismas package list-overlays) ALUCARD_OVERRIDES=\$(dismas flake list-overrides $HOMELAB_CONFIGURATIONS) alucard deploy host --flake $HOMELAB_CONFIGURATIONS --target remote --type development";
    "deploy-user" = "ALUCARD_OVERLAYS=\$(dismas package list-overlays) ALUCARD_OVERRIDES=\$(dismas flake list-overrides $USER_ENVIRONMENT_CONFIGURATIONS) alucard deploy user --flake $USER_ENVIRONMENT_CONFIGURATIONS --type development";
  };
}
