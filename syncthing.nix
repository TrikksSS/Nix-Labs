{ pkgs, lib, config, ... }:
{
# Example for /etc/nixos/configuration.nix
services.syncthing = {
  enable = true;
  openDefaultPorts = true; # Open ports in the firewall for Syncthing. (NOTE: this will not open syncthing gui port)

  guiAddress = "0.0.0.0:8384"; # By default syncthing only listens to localhost
};

# port 8384  is the default port to allow access from the network.
networking.firewall.allowedTCPPorts = [ 8384 ];

}

