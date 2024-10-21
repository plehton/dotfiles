{ pkgs, home-manager } :
{
        # Home manager
        home-manager.darwinModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
          };

          home-manager.users.pjl = { pkgs, ...} : {

            home.stateVersion = "24.11";

            home.packages = with pkgs; [
              curl
              fd
              git
              neovim
              nixfmt-rfc-style
              ripgrep
              wget
            ];

            programs = {
              # alacritty = {
              #   enable = false;
              #   settings.font.normal.family = "Jetbrains Mono";
              #   settings.fong.size = 14;
              # };
              bat.enable = true;
              fzf = {
                enable = true;
                enableZshIntegration = true;
                defaultCommand = "fd --type f --follow --hidden --exclude .git";
              };
              lazygit.enable = true;
              z-lua = {
                enable = true;
                enableZshIntegration = true;
                enableAliases = false;
                options = [ "fzf" "once" ];
              };
              zsh = {
                enable = true;
                autocd = true;
                autosuggestion.enable = true;
                enableCompletion = true;
                historySubstringSearch.enable = true;
                syntaxHighlighting.enable = true;
                initExtra = builtins.readFile "$HOME/code/dotfiles/zshrc";
              };

            };
          };
        }
}
