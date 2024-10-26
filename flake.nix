{
  description = "Petri's NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }:
  let
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.aarch64-linux;
    username = "pjl";
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./hardware/aarch64utm.nix
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = {
              imports = [ ./home.nix ];
            };
          }
        ];
        specialArgs = {
          inherit username;
        };
      };
    };
  };
}
