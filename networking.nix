{ config, pkgs, ...}:
{
  
  ####################################################################################################
  # Networking Configuration
  ####################################################################################################

    

  # Define your hostname.
  networking.hostName = "m1"; 
  # Enables wireless support via wpa_supplicant.
  # networking.wireless.enable = true;  

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall.allowedTCPPorts = [ 22 ];




  # EOF
  ####################################################################################################

}
