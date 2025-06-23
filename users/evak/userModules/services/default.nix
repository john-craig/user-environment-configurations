{ config, pkgs, ... }:

{
  imports = [
    ./garbageCollect
    ./torify
  ];
}