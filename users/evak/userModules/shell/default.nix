{ config, pkgs, ... }:
{
  imports = [
    ./aliases
    ./completions
    ./path
    ./plugins
    ./variables
  ];

  programs.zsh = {
    enable = true;

    initExtra = ''
      # This is stupid but it works
      unset __HM_SESS_VARS_SOURCED
      source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    '';
  };
}
