{ pkgs, lib, config, ... }:
{
  # Only set this if using intel-vaapi-driver:
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  systemd.services.jellyfin.environment.LIBVA_DRIVER_NAME = "iHD"; # or i965 for older GPUs
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };

  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      intel-ocl # Generic OpenCL support

      # For Broadwell and newer (ca. 2014+), use with LIBVA_DRIVER_NAME=iHD:
      intel-media-driver
      # For older processors:
      intel-compute-runtime-legacy1

    ];
  };

  services.jellyfin.enable = true;
}

