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

	programs.ssh.startAgent = true;
  #programs.hyprland.enable = true;
	services.openssh.enable = true;
	
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "pjl" ];
  
  system.stateVersion = "24.05";
}
