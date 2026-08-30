{ config, pkgs, ... }:

{

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
    };
  };

  # Enable the Tailscale daemon
  # services.tailscale.enable = true;

  services.tailscale = {
    enable = true;
    # Required on NixOS to permit the server to route outbound network packets
    # useRoutingFeatures = "server"; 
  };

  # Ensure the host OS allows IP packet forwarding globally
  # boot.kernel.sysctl = {
  #   "net.ipv4.ip_forward" = 1;
  #   "net.ipv6.conf.all.forwarding" = 1;
  # };


  # Optional: open the default firewall port for Tailscale
  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  # Optional: install the tailscale CLI utility into your system environment
  environment.systemPackages = [ pkgs.tailscale ];


 # to trick the server into thinking a monitor is attached, so i never freezes again
  boot.kernelParams = [
    "video=HDMI-a-1:1920*1080@60e"
  ];

















  
  
}
