{ pkgs, userName, ... }:
{
	nixpkgs.hostPlatform = "aarch64-darwin";
	services.nix-daemon.enable = true;

	# Shell
	environment.loginShell = pkgs.zsh;
	environment.shells = [ pkgs.bash pkgs.zsh ];
	programs.zsh.enable = true; # default shell on catalina

	users.users.pjl = {
    home = "/Users/${userName}";
    packages = with pkgs; [
      karabiner-elements 
      ];
    };

  environment.pathsToLink = [ "/share/zsh" ];
  environment.systemPackages = with pkgs; [
    git
    vim
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

  nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = 5;
}
