{
  description = "Petri's NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs  = { self, nixpkgs, home-manager, nixos-wsl, ... }:
   let
     lib = nixpkgs.lib;
     system = "x86_64-linux";
     pkgs = nixpkgs.legacyPackages.${system};
	 in {
     nixosConfigurations = {
			 wsl = lib.nixosSystem {
				 inherit system;
				 modules = [
					 nixos-wsl.nixosModules.default
					./wsl.nix
					home-manager.nixosModules.home-manager {
					  home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.pjl = {
							imports = [ ./home.nix ];
						};
					}
				];
			};
		};

#		 homeConfigurations = {
#			 pjl = home-manager.lib.homeManagerConfiguration {
#				 inherit pkgs;
#				 modules = [ ./home.nix ];
#			 };
#		 };
	 };
}
