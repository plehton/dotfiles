{ config, pkgs, userName, ... }:
{
  home.username = userName;
  home.homeDirectory = "/Users/${userName}";

  imports = [
   ./modules/zsh.nix
   ./modules/programs.nix
   ./modules/home_packages.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "24.05";

}
