{ config, pkgs, ... }: {
  # 1. Enable Docker
  virtualisation.docker.enable = true;

  # 2. Open firewall ports
  networking.firewall.allowedTCPPorts = [ 80 443 3000 ];

  # 3. Systemd service to auto-initialize Docker Swarm (Dokploy requirement)
  systemd.services.init-swarm = {
    description = "Initialize Docker Swarm for Dokploy";
    after = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];
    script = ''
      if ! ${pkgs.docker}/bin/docker info | grep -q "Swarm: active"; then
        ${pkgs.docker}/bin/docker swarm init --advertise-addr 127.0.0.1
      fi
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

  # 4. Declarative Dokploy container deployment
  virtualisation.oci-containers = {
    backend = "docker";
    containers."dokploy" = {
      image = "dokploy/dokploy:latest";
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
        "/etc/dokploy:/etc/dokploy"
      ];
      ports = [
        "3000:3000"
      ];
      environment = {
        TRAEFIK_SSL_PORT = "443";
        PORT = "3000";
      };
      extraOptions = [ "--network=host" ];
    };
  };
}
