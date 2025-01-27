# This file contains host-specific configuration for "nixstation", my primary desktop computer
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  nixpkgs.config.allowUnfree = true; # Allow unfree packages on this host

  # CPU
  hardware.cpu.intel.updateMicrocode = true;

  # NVIDIA Drivers
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Network
  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;

  # Kernel
  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  # Date & Time
  time.timeZone = "Europe/Berlin";

  # Region & Locale
  services.xserver.xkb.layout = "de";

  # Boot
  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };

  # File system mounts
  # Root is ephemeral in-memory tmpfs
  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = ["size=1G" "mode=755"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    neededForBoot = true;
    fsType = "vfat";
  };

  fileSystems."/nix" = {
    device = "/dev/root_vg/root";
    neededForBoot = true;
    fsType = "btrfs";
    options = ["noatime" "discard" "subvol=nix" "compress=zstd"];
  };

  fileSystems."/persist" = {
    neededForBoot = true;
    device = "/dev/root_vg/root";
    fsType = "btrfs";
    options = ["noatime" "discard" "subvol=persist" "compress=zstd"];
  };

  swapDevices = [
    {device = "/dev/root_vg/swap";}
  ];

  # Impermanence
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/bluetooth"
    ];
    files = ["/etc/machine-id"]; # TODO persist /etc/machine-id in a declarative manner
    users.sebastian = {
      directories = [
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "nixos-config"
        "Pictures"
        "Videos"
      ];
    };
  };
}
