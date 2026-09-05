{ config, pkgs, ... }:

{
  imports = [
    ./virtualization.nix
    ./services.nix
    ./k3s.nix
    # ./dokploy.nix # Kept commented out as it was before
  ];
}
