{ pkgs, stdenv, userName, ... } :  
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{

      programs.home-manager.enable = true;

      home.username = userName;
      home.homeDirectory = (if isDarwin then "/Users/" else "/home/") + userName;

      imports = [
        ./modules/zsh.nix
        ./modules/cli.nix
        ./modules/home-packages.nix
      ];

      home.stateVersion = "24.05";
}

