{...} : {
  programs = {
    kitty = {
      enable = true;
    };
    wezterm = {
      enable = true;
      extraConfig = builtins.readFile ../config/wezterm/wezterm.lua;
    };
  };
}
