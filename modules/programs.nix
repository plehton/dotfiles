{...} : {
  programs = {
    alacritty.enable = true;
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
    };
    gh-dash.enable = true;
    direnv.enable = true;
    kitty.enable = true;
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
    wezterm.enable = true;
    z-lua = {
      enable = true;
      enableZshIntegration = true;
      options = [ "once" "fzf" ];
    };
  };
     }
