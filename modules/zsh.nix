{...}:{
  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion = {
      enable = true;
      strategy = [ "completion" "history" ];
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
      ls = "ls --color=tty";
      l = "ls -al";
      ll = "ls -l";
      cl = "clear";
    };
    syntaxHighlighting.enable = true;
  };
}
