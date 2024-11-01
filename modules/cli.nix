{ pkgs, ... } : {
  programs = {
    bat.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f --follow --hidden --exclude .git";
    };
    gh = {
      enable = true;
    };
    tmux = {
      enable = true;
      prefix = "C-a";
      baseIndex = 1;
      clock24 = true;
      historyLimit = 10000;
      keyMode = "vi";
      terminal = "xterm-256color";
      extraConfig = "set -g default-command ${pkgs.zsh}/bin/zsh";
    };
    z-lua = {
      enable = true;
      enableZshIntegration = true;
      options = [ "once" "fzf" ];
    };
  };

}
