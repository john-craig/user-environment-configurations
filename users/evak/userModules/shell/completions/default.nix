{ config, pkgs, lib, ... }:
{
  programs.zsh.completionInit =
    lib.mkAfter ''
      eval "$(_DISMAS_COMPLETE=zsh_source dismas)"
      eval "$(_ALUCARD_COMPLETE=zsh_source alucard)"
    '';
}
