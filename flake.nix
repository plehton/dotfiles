{
  description = "Petri's NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, darwin, ... }:
    let
    lib = nixpkgs.lib;
  pkgs = nixpkgs.legacyPackages.aarch64-linux;
  userName = "pjl";
  userRealName = "Petri Lehtonen";
  in {

    # Macbook
    darwinConfigurations.MV9J7YK4N9 = darwin.lib.darwinSystem {
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${userName}.imports = [
              ./home.nix
            ];
          };
        }
      ];
    };

    # UTM VM
      nixosConfigurations.utmos = lib.nixosSystem rec {
        specialArgs = {
          hostName = "utmos";
          inherit userName;
          inherit userRealName;
        };
        system = "aarch64-linux";
        modules = [
          ./hardware/aarch64utm.nix
          ./configuration.nix
          home-manager.nixosModules.home-manager 
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${userName}.imports = [
                ./home.nix
              ];
              extraSpecialArgs = specialArgs;
            };
          }
        ];
      };
  };
}
