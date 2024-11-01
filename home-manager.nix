{ pkgs, stdenv, userName, ... } :
let
  isDarwin = pkgs.stdenv.isDarwin;
in
  {

  programs.home-manager.enable = true;

  home.username = userName;
  home.homeDirectory = (if isDarwin then "/Users/" else "/home/") + userName;

  programs.git = {
    enable = true;
    userName = "Petri Lehtonen";
    userEmail = "petri.j.lehtonen@gmail.com";
    aliases = {
      co = "checkout";
      st = "status";
      sw = "switch";
      l = "log --oneline";
    };
    extraConfig = {
      core = {
        excludeFile = "$HOME/.gitignore";
      };
    };
  };

  imports = [
    ./modules/zsh.nix
    ./modules/cli.nix
    ./modules/gui.nix
    ./modules/nvim.nix
    ./modules/home-packages.nix
  ];

  home.packages = [
  ];

  home.stateVersion = "24.05";
}

