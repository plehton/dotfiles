{...}:{
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion = {
      enable = true;
      strategy = [ "completion" "history" ];
    };
    history = {
      append = true;
      expireDuplicatesFirst = true;
      ignoreSpace = true;
      path = "$HOME/.history";
    };
    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "^[[A" "^P" ];
      searchDownKey = ["^[[B" "^N" ];
    };
    localVariables = {};
    shellGlobalAliases = {
      CP = "|pbcopy";
      FZF = "|fzf";
    };
    shellAliases = {
      ls = "ls --color=tty";
      l = "ls -al";
      ll = "ls -l";
      cl = "clear";
    };
    syntaxHighlighting.enable = true;

    initExtra = builtins.readFile ./zsh.init;

    completionInit = /* bash */''
      autoload -Uz compinit
      if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' $HOME/.zcompdump) ]; then
        compinit
      else
        compinit -C
      fi
    '';

  };

}
