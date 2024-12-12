{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;

    userName = "john-craig";
    userEmail = "john.e.craig.jr@gmail.com";

    signing.key = "466F8511EF2F86C8598F63900D742FFDAF9353C8";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
