{ config, pkgs, ... }:
{
  home.username = "pjl";
  home.homeDirectory = "/home/pjl";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    zsh = {
      enable = true;
      autocd = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        cl = "clear";
      };
    };
  };

  home.packages = with pkgs; [
    curl
    fd
    git
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    lazygit
    ripgrep
    z-lua
  ];

# Home Manager is pretty good at managing dotfiles. The primary way to manage
# plain files is through 'home.file'.
  home.file.".gitconfig".text = ''
    [user]
    name = Petri Lehtonen
      email = petri.j.lehtonen@gmail.com

      [alias]
      sw = switch
        co = checkout
        '';
  home.sessionVariables = {
  };

  home.stateVersion = "24.05";

}
