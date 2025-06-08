# This file contains common system-level configuration for all hosts
{
  pkgs,
  lib,
  ...
}: {
  system.stateVersion = "25.05";

  # TODO: Move to separate file
  # GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [pkgs.xterm]; # Exclude xterm

  # Enable Wayland for Chromium/Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Exclude GNOME packages I don't need
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    yelp
    gnome-console
    snapshot
    gnome-music
    geary
    simple-scan
    totem
  ];

  security.polkit.enable = true;
  services.displayManager.sessionPackages = [pkgs.swayfx];
  home-manager.users.sebastian.wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx.override {
      # The home-manager module only applies extraOptions to the default sway package for some reason
      # Thus it only applies when not specifying a custom package
      # We can, however, override extraOptions manually:
      extraOptions = ["--unsupported-gpu"];
    };
    config = {
      output."*" = {
        background = "~/Pictures/amber-d.png fill";
      };
      startup = [
        {command = "wlsunset -l 49.4 -L 8.7 -t 2000";}
      ];
      keybindings = lib.mkOptionDefault {
        # Volume controls
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        # Media controls
        "Control+XF86AudioRaiseVolume" = "exec playerctl next"; # Next
        "Control+XF86AudioLowerVolume" = "exec playerctl previous"; # Previous
        "Control+XF86AudioMute" = "exec playerctl play-pause"; # Play/Pause
        "Control+Shift+XF86AudioRaiseVolume" = "exec playerctl position 5+"; # Seek forward
        "Control+Shift+XF86AudioLowerVolume" = "exec playerctl position 5-"; # Seek backward
      };
    };
    checkConfig = false; # Is this required?
    #extraOptions = ["--unsupported-gpu"]; # See above
    wrapperFeatures.gtk = true;
  };

  systemd.user.services.playerctld = {
    enable = true;
    wantedBy = ["default.target"];
    description = "Keep track of media player activity";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.playerctl}/bin/playerctld daemon";
    };
  };

  # Keyring
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  programs.seahorse.enable = true;

  # Sound
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
  };

  # Some basic packages
  environment.systemPackages = with pkgs; [
    (vim.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall)
        + ''
          sed -i '/^MimeType=/d' $out/share/applications/*.desktop
        '';
    }))
    git
    wlsunset
    playerctl
    file
    ripgrep-all
  ];

  # Allow execution of nixos-rebuild without password prompt
  security.sudo.extraRules = [
    {
      users = ["sebastian"];
      commands = [
        {
          command = "/run/current-system/sw/bin/nixos-rebuild";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
