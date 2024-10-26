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
      autosuggestion = {
        enable = true;
        strategy = [ "history" "completion" ];
      };
      enableCompletion = true;
      history = {
        append = true;
        expireDuplicatesFirst = true;
        ignoreAllDups = true;
        ignoreSpace = true;
      };
      historySubstringSearch.enable = true;
      initExtra = "";
      localVariables = {};
      shellGlobalAliases = {
        CP = "|pbcopy";
        FZF = "|fzf";
      };
      shellAliases = {
        cl = "clear";
      };
      syntaxHighlighting.enable = true;
    };
    z-lua = {
      enable = true;
      enableZshIntegration = true;
      options = [ "once" "fzf" ];
    };
  };

  home.packages = with pkgs; [
    curl
    fd
    git
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    lazygit
    ripgrep
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
