{...} : {
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
        l = "log --oneline";
      };
    };
    gh = {
      enable = true;
    };
    direnv.enable = true;
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      #withPython3 = true;
      #withNodeJs= true;
      #withRuby = true;
    };
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
    z-lua = {
      enable = true;
      enableZshIntegration = true;
      options = [ "once" "fzf" ];
    };
  };
}
