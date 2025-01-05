{ config, pkgs, ... }:
{
  home.file = {
    ".config/pipewire/pipewire.conf.d/loopback-instrument.conf".source = ./loopback-instrument.conf;
    ".config/pipewire/pipewire.conf.d/echo-cancellation.conf".source = ./echo-cancellation.conf;
  };
}
