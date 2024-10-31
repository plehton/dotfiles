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
        ./modules/gui.nix
        ./modules/nvim.nix
        ./modules/home-packages.nix
      ];

      home.packages = [
        (pkgs.nerdfonts.override { fonts = [ "BitstreamVeraSansMono" "FiraCode" "JetBrainsMono" ]; })
      ];
      home.stateVersion = "24.05";
}

