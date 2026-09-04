{
  description = "My Nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nix-dokploy.url = "github:el-kurto/nix-dokploy";
  };

  outputs = { self, nixpkgs, nix-dokploy, ... } @ inputs :
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        m1 = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            nix-dokploy.nixosModules.default # <--- This handles the multi-container setup
         
          ];

        };

      };

    };   

}
