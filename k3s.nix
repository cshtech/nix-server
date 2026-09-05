{ pkgs, ... }:

{
  # 1. Enable K3s as a Server (Control Plane + Worker)
  services.k3s.enable = true;
  services.k3s.role = "server";
  
  services.k3s.extraFlags = toString [
    "--cluster-init"          # Initializes embedded etcd (perfect for single or multi-master control planes)
    "--disable traefik"       # Recommended: Disables default Traefik so you can deploy an ingress later
    "--disable local-storage" # Optional: Disable if using custom CSI like Longhorn
  ];

  # 2. Open Firewall Ports required for the Control Plane
  networking.firewall.allowedTCPPorts = [ 
    6443 # Kubernetes API Server
    2379 # Etcd client requests (needed if adding more control planes)
    2380 # Etcd peer communication (needed if adding more control planes)
  ];
  
  networking.firewall.allowedUDPPorts = [
    8472 # Flannel VXLAN overlay network (for pod-to-pod communication)
  ];

  # 3. System Utilities
  environment.systemPackages = with pkgs; [
    k3s
    kubectl
    kubernetes-helm
    kompose
  ];
}
