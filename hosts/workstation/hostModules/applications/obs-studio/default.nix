{ config, pkgs, lib, ... }: {
  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      # obs-websocket
      # obs-v4l2sink
      # obs-virtualcam
      # obs-ffmpeg
      # obs-rtmp
    ];
  };
}