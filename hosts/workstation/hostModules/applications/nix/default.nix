{ config, pkgs, ... }:
{
  nix.extraOptions = ''
    # Used for cross-compilation
    extra-platforms = aarch64-linux arm-linux
    extra-sandbox-paths = /usr/bin/qemu-aarch64-static

    download-buffer-size = 2147483648
  '';
}
