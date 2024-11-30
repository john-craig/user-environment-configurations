{ config, pkgs, ... }:
{
  programs.zsh.completionInit = ''
    autoload -U compinit && compinit
    eval "$(_DISMAS_COMPLETE=zsh_source dismas)"
    eval "$(_ALUCARD_COMPLETE=zsh_source alucard)"
  '';
}