{ pkgs, ... }: {
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
}


