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

  networking.firewall.allowedTCPPorts = [

    # SSH Access
    22

    # Portainer
    9443

    # Immich
    2283

    # Nginx proxy manager
    # http
    80
    # https
    443
    # admin panel
    81

    # goaccess
    7880 
    
  ];

  # Lower the Privileged Port Range in NixOS
  # You need to tell the NixOS kernel that regular users
  # are allowed to bind to ports down to 80.
  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;



  # EOF
  ####################################################################################################

}
