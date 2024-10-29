{
  description = "Petri's NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }:
  let
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.aarch64-linux;
    userName = "pjl";
    userRealName = "Petri Lehtonen";
    hostName = "utmos";
  in {
    nixosConfigurations = 
    {
      # UTM Virtual machine
      utmos = lib.nixosSystem rec {
        specialArgs = {
          hostName = "utmos";
          inherit userName;
          inherit userRealName;
        };
        system = "aarch64-linux";
        modules = [
          ./hardware/aarch64utm.nix
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${userName}.imports = [
                  ./home.nix
                ];
              extraSpecialArgs = specialArgs;
            };
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };
    };
  };
}
