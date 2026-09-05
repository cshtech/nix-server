{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./base-system.nix
      ./networking.nix
      ./programs.nix  	
      ./packages.nix
      ./accounts.nix
      ./virtualization.nix
      ./services.nix
      # ./dokploy.nix
      ./k3s.nix
      
    ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System State Version
  system.stateVersion = "26.05";
  
}
