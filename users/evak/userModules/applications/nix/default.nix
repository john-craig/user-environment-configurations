{ config, pkgs, ... }:
{
  nix.extraOptions = ''
    experimental-features = nix-command flakes

    substituters = https://cache.nix.chiliahedron.wtf/
    trusted-public-keys = pxe_server:TT307Bq/qCuarPYKr12W3EvfOMO1kqKAzji6pGICZes=
  '';
}
