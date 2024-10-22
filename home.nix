{ config, pkgs, ... }:

{
  home.stateVersion = "24.05";

  home.username = "pjl";
  home.homeDirectory = "/home/pjl";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

	programs = {
		zsh = {
			enable = true;
			enableCompletion = true;
			shellAliases = {
				ll = "ls -l";
				cl = "clear";
			};
		};
	};

  home.packages = with pkgs; [
		curl
		git
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
		lazygit
		ripgrep
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file.".gitconfig".text = ''
		[user]
		name = Petri Lehtonen
		email = petri.j.lehtonen@gmail.com

		[alias]
		sw = switch
	'';

  home.sessionVariables = {

  };

}
