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
        ./modules/home-packages.nix
      ];

      xdg.enable = true;

      home.packages = [
        (pkgs.nerdfonts.override { fonts = [ "BitstreamVeraSansMono" "FiraCode" "JetBrainsMono" ]; })
      ];

      xdg.configFile = {
        nvim = {
          enable = true;
          source = ./config/nvim;
        };
        #"wezterm/wezterm.lua" = {
        #  enable = true;
        #  source = ./config/wezterm/wezterm.lua;
        #};
        "wezterm" = {
          enable = true;
          source = ./config/wezterm;
        };
      };

      home.stateVersion = "24.05";
}

