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
  services.tailscale.enable = true;

  # Optional: open the default firewall port for Tailscale
  networking.firewall.allowedUDPPorts = [ config.services.tailscale.port ];

  # Optional: install the tailscale CLI utility into your system environment
  environment.systemPackages = [ pkgs.tailscale ];

  
}
