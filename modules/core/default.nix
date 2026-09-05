{ config, pkgs, ... }:

{
  imports = [
    ./base-system.nix
    ./networking.nix
    ./programs.nix
    ./packages.nix
  ];
}
