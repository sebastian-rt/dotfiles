{device ? throw "Device not specified!", ...}: let
  diskSize = 931.51; # Total size of the disk to partition in GiB
  pvSize = builtins.ceil (0.33 * diskSize); # Size of the LVM physical volume relative to the total disk size (32% of 931.5 GiB ~ 298.5 GiB)
  homeSize = builtins.ceil (0.27 * diskSize); # Size of the shared home partition relative to the total disk size (25% of 931.5 GiB ~ 232.8 GiB)
in {
  disko.devices = {
    nodev = {
      "/" = {
        # Ephemeral tmpfs root
        fsType = "tmpfs";
        mountOptions = [
          "size=10G" # Max size of tmpfs root; adjust as needed
          "mode=0755" # tmpfs has 1777 permissions by default
        ];
      };
    };
    disk.nvme = {
      inherit device;
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            # Shared EFI System Partition
            label = "EFI system partition";
            type = "EF00";
            size = "512M";
            priority = 100;
            content = {
              type = "filesystem";
              format = "vfat";
              extraArgs = ["-F32"];
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };
          nixos_pv = {
            # LVM PV for NixOS nix-store and swap
            label = "nixos_pv";
            size = "${builtins.toString pvSize}G";
            priority = 1000;
            content = {
              type = "lvm_pv";
              vg = "nixos_vg";
            };
          };
          home = {
            # Home partition shared between NixOS and Windows
            label = "Home";
            size = "${builtins.toString homeSize}G";
            priority = 1001;
            content = {
              type = "btrfs";
              mountpoint = "/persist/user";
              mountOptions = ["noatime" "compress=zstd"];
            };
          };
          # Unused space for windows installation
        };
      };
    };
    lvm_vg.nixos_vg = {
      type = "lvm_vg";
      lvs = {
        swap = {
          size = "${builtins.toString (builtins.ceil (0.033 * pvSize))}G"; # 3.3% of the total PV size
          content = {
            type = "swap";
          };
        };
        root = {
          size = "100%FREE";
          content = {
            type = "btrfs";
            extraArgs = ["-f"];
            subvolumes = {
              "/persist" = {
                mountOptions = ["subvol=persist" "noatime" "compress=zstd"];
                mountpoint = "/persist/system";
              };
              "/nix" = {
                mountOptions = ["subvol=nix" "noatime"];
                mountpoint = "/nix";
              };
            };
          };
        };
      };
    };
  };
}
