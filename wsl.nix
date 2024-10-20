{ config, lib, pkgs, ... }:

{

  wsl.enable = true;
  wsl.defaultUser = "pjl";

	environment.shells = [ pkgs.zsh ];
	users.defaultUserShell = pkgs.zsh;
	programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    git
    ripgrep
    vim
    wget
 ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  system.stateVersion = "24.05";
}
