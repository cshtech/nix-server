{ pkgs, ... }:

{

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    # defaultNetwork.dnsname.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  virtualisation.containers.registries.search = [ "docker.io" "quay.io" ];

  environment.systemPackages = with pkgs; [ podman-compose ];
  
}
