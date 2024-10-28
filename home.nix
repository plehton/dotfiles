{ config, pkgs, userName, ... }:
{
  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    bat.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f --follow --hidden --exclude .git";
    };
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
    direnv.enable = true;
    tmux = {
      enable = true;
      prefix = "C-a";
      baseIndex = 1;
      clock24 = true;
      historyLimit = 10000;
      keyMode = "vi";
      terminal = "xterm-256color";
      extraConfig = "";
    };
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
    # Base
    curl
    fd
    lazygit
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ripgrep
    tree

    # Work
    awscli2
    fswatch
    databricks-cli
    jq
  ];

  home.sessionVariables = {
  };

  home.stateVersion = "24.05";

}
