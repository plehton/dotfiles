{
  description = "Petri's MacOS Darwin setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, darwin, home-manager, ... }: {

    darwinConfigurations.MV9J7YK4N9 = darwin.lib.darwinSystem {

      modules = [

        # Darwin
        ({ pkgs, ... }: {

          nixpkgs.hostPlatform = "aarch64-darwin";
          services.nix-daemon.enable = true;
          system.stateVersion = 5;

          nix.extraOptions = ''
              experimental-features = nix-command flakes
          '';

          # Shell
          environment.loginShell = pkgs.zsh;
          environment.shells = [ pkgs.bash pkgs.zsh ];
          programs.zsh.enable = true;  # default shell on catalina

          # System level packages for all users
          environment.systemPackages = with pkgs; [
            coreutils
            lua
            nixfmt-rfc-style
          ];

          users.users.pjl.home = "/Users/pjl";

          fonts.packages = [  (pkgs.nerdfonts.override { fonts = ["JetBrainsMono" "FiraCode"]; }) ];

          # MacOS Settings
          security.pam.enableSudoTouchIdAuth = true;
          system.defaults = {
              NSGlobalDomain.AppleShowAllExtensions = true;
              NSGlobalDomain.InitialKeyRepeat = 14;
              NSGlobalDomain.KeyRepeat = 1;
              dock.autohide = true;
              dock.mru-spaces = false;
              finder.AppleShowAllExtensions = true;
              finder._FXShowPosixPathInTitle = true;
              screensaver.askForPasswordDelay = 60;
          };

        }) # darwin module

        # Home manager
        home-manager.darwinModules.home-manager
        {
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
                initExtra = "source $HOME/code/dotfiles/zshrc";
              };

            }; # programs
          }; # users.pjl
        } # home-manager module
      ]; # darwin modules
    }; # darwinSystem
    # darwinPackages = self.darwinConfigurations.MV9J7YK4N9.pkgs;
  };
}

