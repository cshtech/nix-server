{ pkgs, ... }:

{

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    # defaultNetwork.dnsname.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # Unblock containers from adjusting network parameters required by WireGuard
  # Modern and correct way to configure containers.conf in NixOS
    virtualisation.containers.containersConf.settings = {
      containers = {
        allowed_sysctls = [
          "net.ipv4.ip_forward"
          "net.ipv4.conf.all.src_valid_mark"
        ];
      };
    };




  virtualisation.containers.registries.search = [ "docker.io" "quay.io" ];

  # encvironment.systemPackages = with pkgs; [ podman-compose ];

  # Added slirp4netns so rootless Podman networking can execute
  environment.systemPackages = with pkgs; [ 
    podman-compose 
    slirp4netns 
  ];
  
}
