{...} : {
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      #withPython3 = true;
      #withNodeJs= true;
      #withRuby = true;
    };
  };
  home.file = {
    ".config/nvim" = {
        enable = true;
        recursive = true;
        source = ../config/nvim;
    };
  };
}
