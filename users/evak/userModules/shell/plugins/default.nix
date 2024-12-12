{ config, pkgs, ... }:
{

  programs.zsh = {
    plugins = [
      {
        name = "zsh-shift-select";
        src = pkgs.fetchFromGitHub {
          owner = "jirutka";
          repo = "zsh-shift-select";
          rev = "v0.1.1";
          hash = "sha256-4kUUBH2GTMb/d6PUNiSNFogkvDUSwMX823j4xsroJKs=";
        };
      }
      {
        name = "alpine-zsh-config";
        src = pkgs.fetchFromGitHub {
          owner = "jirutka";
          repo = "alpine-zsh-config";
          rev = "v0.5.0";
          hash = "sha256-mbt2Oqdqylup759tUTN2erqDmSv1bH1BcpW2XApHudc=";
        };
        file = "zshrc.d/50-key-bindings.zsh";
      }
      {
        name = "notify";
        src = ./notify;
      }
    ];
  };
}
