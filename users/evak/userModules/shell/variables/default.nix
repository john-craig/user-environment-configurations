{ config, pkgs, ... }:
{
  home.sessionVariables = {
    PS1=" 🛸 ";
    EDITOR = "emacs -nw";

    NIX_REMOTE="daemon";

    HYPRSHOT_DIR="$HOME/media/by_category/images/pictures";

    USER_ENVIRONMENT_CONFIGURATIONS="$HOME/programming/by_category/user_environment/user-environment-configurations";
    HOMELAB_CONFIGURATIONS="$HOME/programming/by_category/homelab/homelab-configurations";
    NIXPKGS_APOCRYPHA="$HOME/programming/by_category/homelab/nixpkgs-apocrypha";

    GALLIPEDAL_SERVICES="$HOME/programming/by_category/selfhosting/gallipedal-library";
    GALLIPEDAL_MODULE="$HOME/programming/by_category/selfhosting/gallipedal-module";
  };
}
