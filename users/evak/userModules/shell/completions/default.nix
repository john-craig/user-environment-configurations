{ config, pkgs, ... }:
{
  programs.zsh.completionInit = ''
    eval "$(_DISMAS_COMPLETE=zsh_source dismas)"
    eval "$(_ALUCARD_COMPLETE=zsh_source alucard)"
  '';
}
