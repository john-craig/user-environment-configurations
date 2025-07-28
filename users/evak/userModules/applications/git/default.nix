{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    pre-commit
  ];

  programs.git = {
    enable = true;

    userName = "john-craig";
    userEmail = "john.e.craig.jr@gmail.com";

    # hooks = {
    #   pre-commit = ./dismas-checker.sh;
    #   pre-push = ./dismas-checker.sh;
    #   pre-rebase = ./dismas-checker.sh;
    # };

    signing.key = "466F8511EF2F86C8598F63900D742FFDAF9353C8";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
