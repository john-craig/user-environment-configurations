{ config, pkgs, lib, ... }:
{
  home.sessionVariables = {
    PS1=" 🛸 ";
    EDITOR = "emacs -nw";

    NIX_REMOTE="daemon";

    HYPRSHOT_DIR="$HOME/media/by_category/images/pictures";

    PROGRAMMING="$HOME/programming";
    DOCUMENTS="$HOME/documents";
    MEDIA="$HOME/media";

    USER_ENVIRONMENT_CONFIGURATIONS="$HOME/programming/by_category/user_environment/user-environment-configurations";
    DISK_IMAGE_CONFIGURATIONS="$HOME/programming/by_category/homelab/disk-image-configurations";
    HOMELAB_CONFIGURATIONS="$HOME/programming/by_category/homelab/homelab-configurations";
    NIXPKGS_APOCRYPHA="$HOME/programming/by_category/homelab/nixpkgs-apocrypha";

    GALLIPEDAL_SERVICES="$HOME/programming/by_category/selfhosting/gallipedal-library";
    GALLIPEDAL_MODULE="$HOME/programming/by_category/selfhosting/gallipedal-module";
  };

  programs.zsh.initExtra = let 
    home_dirs = {
      documents = [
        "by_category"
      ];
      media = [
        "by_category"
      ];
      programming = [
        "by_category"
        "by_language"
      ];
    };
  in lib.attrsets.foldlAttrs
    (acc: basepath: subpaths:
      (acc + (lib.strings.concatMapStrings (subpath: ''
        # Define the base directory
        BASE_DIR="${basepath}/${subpath}"
        BASE_DIR_ABS="$HOME/$BASE_DIR"

        basedir_name=$(dirname "$BASE_DIR")

        # Iterate over each subdirectory in the base directory
        for sub_dir in "$BASE_DIR_ABS"/*; do
            if [[ -d "$sub_dir" ]]; then
                # Extract the language name from the directory path
                subdir_name=$(basename "$sub_dir")

                # Create the environment variable name in the desired format
                var_name="''${basedir_name:u}_''${subdir_name:u}"  # Convert to uppercase

                # Assign the path to the environment variable
                export "$var_name=$sub_dir"
            fi
        done
      '') subpaths)))
    "" home_dirs;
}
