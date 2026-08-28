{
  description = "My Nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
  };

  outputs = { nixpkgs, ... } @ inputs :
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
         
          ];

        };

      };

    };   

}
