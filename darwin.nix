{ pkgs, ... }:
{
	nixpkgs.hostPlatform = "aarch64-darwin";
	services.nix-daemon.enable = true;
	system.stateVersion = 5;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	users.users.pjl = {
    home = "/Users/pjl";
    packages = with pkgs; [
      karabiner-elements 
      ];
    };

	# Shell
	environment.loginShell = pkgs.zsh;
	environment.shells = [ pkgs.bash pkgs.zsh ];
	programs.zsh.enable = true; # default shell on catalina

  environment.systemPackages = with pkgs; [
    coreutils
    git
    vim
    wget
	];

	# MacOS Settings
	security.pam.enableSudoTouchIdAuth = true;
	system.defaults = {
		NSGlobalDomain.AppleShowAllExtensions = true;
		NSGlobalDomain.InitialKeyRepeat = 20;
		NSGlobalDomain.KeyRepeat = 2;
		dock.autohide = true;
		dock.mru-spaces = false;
		finder.AppleShowAllExtensions = true;
		finder._FXShowPosixPathInTitle = true;
		screensaver.askForPasswordDelay = 60;
	};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
