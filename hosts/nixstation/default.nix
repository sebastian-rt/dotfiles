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
    ./monitors.nix
    ./disko-config.nix
    ../../modules/nvidia
  ];

  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persist/system".neededForBoot = true;
  fileSystems."/persist/user".neededForBoot = true;

  nixpkgs.config.allowUnfree = true; # Allow unfree packages on this host

  # CPU
  hardware.cpu.intel.updateMicrocode = true;

  # NVIDIA Drivers
  easyNvidia.enable = true;
  easyNvidia.withIntegratedGPU = false;
  easyNvidia.vaapi.enable = true;
  hardware.nvidia.nvidiaSettings = true;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Monitor Backlight Control
  services.udev.extraRules = let
    bash = "${pkgs.bash}/bin/bash";
    ddcciDev = "NVIDIA i2c adapter 8 at 1:00.0";
    ddcciNode = "/sys/bus/i2c/devices/i2c-11/new_device";
  in ''
    SUBSYSTEM=="i2c", ACTION=="add", ATTR{name}=="${ddcciDev}", RUN+="${bash} -c 'sleep 30; printf ddcci\ 0x37 > ${ddcciNode}'"
  '';

  # Network
  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;
  systemd.network.wait-online.enable = false;
  # The options
  # systemd.network.wait-online.enable
  # boot.initd.systemd.network.wait-online.enable
  # seem to be broken right now.
  # https://discourse.nixos.org/t/error-network-wait-online-service/57902/5
  # Until this is fixed, we can mask the systemd service to disable
  # wait-online:
  systemd.services.NetworkManager-wait-online.enable = false;

  # Wake on LAN
  networking.interfaces.enp4s0.wakeOnLan.enable = true;

  # Connection with apple devices
  services.usbmuxd.enable = true;
  environment.systemPackages = [pkgs.libimobiledevice];

  # Date & Time
  time.timeZone = "Europe/Berlin";

  # Region & Locale
  services.xserver.xkb.layout = "de";
  home-manager.users.sebastian.wayland.windowManager.sway.config = {
    input."*".xkb_layout = "de";
  };

  # Boot
  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };

    kernelModules = ["kvm-intel" "ddcci-backlight"];
    extraModulePackages = with config.boot.kernelPackages; [ddcci-driver];

    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
      verbose = false;
      kernelModules = ["dm-snapshot"];
      systemd.network.wait-online.enable = false; # Seems to be broken; See above
    };

    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    consoleLogLevel = 0;

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  # Power mode (power-profiles-daemon)
  # Performance mode by default
  systemd.tmpfiles.rules = [
    "L+ /var/lib/power-profiles-daemon/state.ini - - - - ${pkgs.writeText "power-profiles-daemon-state.ini" ''
      [State]
      CpuDriver=intel_pstate
      PlatformDriver=placeholder
      Profile=performance
    ''}"
  ];

  # Disable automatic suspend
  home-manager.users.sebastian.dconf.settings = {
    "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";
  };

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    RuntimeMaxUse=50M
  '';

  # Impermanence
  environment.persistence."/persist/system" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/var/lib/cups"
      "/var/lib/nixos"
      "/var/lib/bluetooth"
    ];
    files = ["/etc/machine-id"]; # TODO persist /etc/machine-id in a declarative manner
  };

  environment.persistence."/persist/user" = {
    enable = true;
    hideMounts = true;
    users.sebastian = {
      directories = [
        ".mitmproxy"
        ".librewolf"
        ".local/share/keyrings"
        ".config/sops/age"
        ".ssh"
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "nixos-config"
        "Pictures"
        "Videos"
        "Virtual Machines"
      ];
    };
  };
}
