{ config, pkgs, ... }:
{
  programs.zsh.shellAliases = {
    "deploy-host" = "ALUCARD_OVERLAYS=\$(dismas package list-overlays) ALUCARD_OVERRIDES=\$(dismas repository list-overrides $HOMELAB_CONFIGURATIONS) alucard deploy host --flake $HOMELAB_CONFIGURATIONS --target remote --type development";
    "deploy-user" = "ALUCARD_OVERLAYS=\$(dismas package list-overlays) ALUCARD_OVERRIDES=\$(dismas repository list-overrides $USER_ENVIRONMENT_CONFIGURATIONS) alucard deploy user --flake $USER_ENVIRONMENT_CONFIGURATIONS --type development";
    "deploy-cluster" = "ALUCARD_OVERLAYS=\$(dismas package list-overlays) ALUCARD_OVERRIDES=\$(dismas repository list-overrides $HOMELAB_CONFIGURATIONS) alucard deploy cluster --flake $HOMELAB_CONFIGURATIONS --type development";
    
    "build-machine" = "ALUCARD_OVERLAYS=\$(dismas package list-overlays) ALUCARD_OVERRIDES=\$(dismas repository list-overrides $VIRTUAL_MACHINE_CONFIGURATIONS) alucard build machine --flake $VIRTUAL_MACHINE_CONFIGURATIONS";
    "start-machine" = "alucard start machine";

    "build-image" = "ALUCARD_OVERLAYS=\$(dismas package list-overlays) ALUCARD_OVERRIDES=\$(dismas repository list-overrides $VIRTUAL_MACHINE_CONFIGURATIONS) alucard build image --flake $DISK_IMAGE_CONFIGURATIONS";
    "install-image" = "alucard install image";
  };
}
