{ config, pkgs, userName, ... }:
{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    git = {
      enable = true;
      userName = "Petri Lehtonen";
      userEmail = "petri.j.lehtonen@gmail.com";
      aliases = {
        co = "checkout";
        st = "status";
        sw = "switch";
      };
    };
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
    gh-dash.enable = true;
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
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    lazygit
    ripgrep
  ];

  home.sessionVariables = {
  };

  home.stateVersion = "24.05";

}
