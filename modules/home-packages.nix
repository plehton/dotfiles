{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Base
    (nerdfonts.override { fonts = [ "BitstreamVeraSansMono" "FiraCode" "JetBrainsMono" ]; })
    curl
    fd
    lazygit
    ripgrep
    tree

    # Work
    awscli2
    fswatch
    databricks-cli
    jq

    # Dev
    devenv
  ];
}
