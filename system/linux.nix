{ config, pkgs, userName, userRealName, hostName, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define hostname
  networking.hostName = hostName;

  # Enable networking
  networking.networkmanager.enable = true;

  # Shells
  programs.zsh.enable = true;
  environment.shells = [ pkgs.bash pkgs.zsh ];

  users.users.${userName}= {
    isNormalUser = true;
    description = userRealName;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nix.settings.trusted-users = [ "root" userName ];

  environment.pathsToLink = [ "/share/zsh" ];

  time.timeZone = "Europe/Helsinki";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    gcc
    git
    vim
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.05"; # Did you read the comment?

}
