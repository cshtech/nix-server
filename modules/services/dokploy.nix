{ config, pkgs, lib, ... }:

let
  hostProjectPath = "/home/csh/projects";
in
{
  # 1. Enable Docker and open standard networking ports
  virtualisation.docker.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 3000 ];

  # 2. Maintain your project storage folders on the host
  systemd.tmpfiles.rules = [
    "d ${hostProjectPath} 0755 csh users -"
    "d ${hostProjectPath}/dokploy-backups 0755 csh users -"
  ];

  # 3. Clean, pure Dokploy module execution
  services.dokploy = {
    enable = true;
    
    # Core system secrets read dynamically at boot time
    database.passwordFile = "/srv/nixos/nixcfg/secrets/dokploy-db-password";
    auth.secretFile = "/srv/nixos/nixcfg/secrets/dokploy-auth-secret";
    encryption.keyFile = "/srv/nixos/nixcfg/secrets/dokploy-encryption-key";
  };

  # 🔐 Runtime Injection: Feeds your Cloudflare credentials straight into the container environment
  systemd.services.docker-dokploy-init.serviceConfig.EnvironmentFile = "/srv/nixos/nixcfg/secrets/dokploy-cloudflare.env";
  systemd.services.dokploy-traefik.serviceConfig.EnvironmentFile = "/srv/nixos/nixcfg/secrets/dokploy-cloudflare.env";
}
