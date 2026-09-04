{ config, pkgs, lib, ... }:

let
  hostProjectPath = "/home/csh/projects";
in
{
  # 1. Enable Docker (Fixes the current assertion error)
  virtualisation.docker.enable = true;

  # 2. Open required ports globally on NixOS firewall
  networking.firewall.allowedTCPPorts = [ 80 443 3000 ];

  # 3. Ensure persistent project directories exist for user 'csh'
  systemd.tmpfiles.rules = [
    "d ${hostProjectPath} 0755 csh users -"
    "d ${hostProjectPath}/dokploy-backups 0755 csh users -"
  ];

  # 4. Dokploy module configuration
  services.dokploy = {
    enable = true;
    
    database.passwordFile = "/var/lib/secrets/dokploy-db-password";
    auth.secretFile = "/var/lib/secrets/dokploy-auth-secret";
    encryption.keyFile = "/var/lib/secrets/dokploy-encryption-key";
  };
}
