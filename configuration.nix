# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./pi-hole.nix
      ./jellyfin.nix
      ./ollama.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
   time.timeZone = "America/New_York";

   users.users.nix = {
     isNormalUser = true;
     extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
	fastfetch
     ];
   };

  fileSystems."/home/nix/media" = {
	device = "/dev/disk/by-uuid/44c4bda9-45be-4265-b3f8-170c002519b0";
	fsType = "btrfs";
	options = ["nofail"];
};  

virtualisation.docker = {
  enable = true;
};

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     vim
     wget
     git 
     bind
     iptables
     borgbackup
     pkgs.ollama
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh = {
	enable = true;
	settings = {
	  PermitRootLogin = "no";
	};
    };

 networking.firewall = {
	enable = true;
	allowedTCPPorts = [ 53 80 8096 ];
	allowedUDPPorts = [ 53 ];
  };
  
  nix.gc = {
	automatic = true;
	dates = "weekly";
	options = "--delete-older-than-30d";
  };
nix.settings.auto-optimise-store = true;
boot.loader.systemd-boot.configurationLimit = 10;

  system.stateVersion = "26.05"; # Do NOT CHANGE

}

