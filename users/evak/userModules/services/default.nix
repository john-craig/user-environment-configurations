{ config, pkgs, ... }:

{
  imports = [
    ./activityTracking
    ./garbageCollect
    ./torify
  ];
}