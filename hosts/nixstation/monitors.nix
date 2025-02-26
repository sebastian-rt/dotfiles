{pkgs, ...}: let
  monitorsXml = ''
    <monitors version="2">
      <configuration>
        <layoutmode>physical</layoutmode>
        <logicalmonitor>
          <x>0</x>
          <y>0</y>
          <scale>1</scale>
          <primary>yes</primary>
          <monitor>
            <monitorspec>
              <connector>DP-3</connector>
              <vendor>XMI</vendor>
              <product>Mi Monitor</product>
              <serial>0x00000000</serial>
            </monitorspec>
            <mode>
              <width>3440</width>
              <height>1440</height>
              <rate>144.000</rate>
            </mode>
          </monitor>
        </logicalmonitor>
      </configuration>
      <configuration>
        <layoutmode>physical</layoutmode>
        <logicalmonitor>
          <x>0</x>
          <y>0</y>
          <scale>1</scale>
          <primary>yes</primary>
          <monitor>
            <monitorspec>
              <connector>DP-1</connector>
              <vendor>XMI</vendor>
              <product>Mi Monitor</product>
              <serial>0x00000000</serial>
            </monitorspec>
            <mode>
              <width>3440</width>
              <height>1440</height>
              <rate>144.000</rate>
            </mode>
          </monitor>
        </logicalmonitor>
      </configuration>
    </monitors>
  '';
in {
  # Set primary display to 144Hz refresh rate (GNOME)
  # This has to be set on a per-user basis
  home-manager.users.sebastian.home.file.".config/monitors.xml".text = monitorsXml;

  # Apply the monitor configuration to GDM
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${pkgs.writeText "gdm-monitors.xml" monitorsXml}"
  ];

  # Set output mode for sway(fx)
  home-manager.users.sebastian.wayland.windowManager.sway.config = {
    output = {
      "DP-3" = {
        mode = "3440x1440@144.000Hz";
      };
    };
  };
}
