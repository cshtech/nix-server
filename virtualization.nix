{ pkgs, ... }:

{

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    # defaultNetwork.dnsname.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages = with pkgs; [ podman-compose ];
  
}
