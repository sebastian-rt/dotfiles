{pkgs, ...}: {
  home-manager.users.sebastian.home.packages = with pkgs; [
    resources
  ];

  home-manager.users.sebastian.dconf.settings = {
    "net/nokyan/Resources" = {
      last-viewed-page = "applications"; # Show "Applications" tab on startup
      sidebar-meter-type = "Graph";
      refresh-speed = "Fast";
      # CPU
      show-logical-cpus = true;
      normalize-cpu-usage = true;
      # "Apps" tab
      apps-show-drive-read-speed = true;
      apps-show-drive-write-speed = true;
      apps-show-gpu = true;
      apps-show-gpu-memory = true;
      apps-show-encoder = true;
      apps-show-decoder = true;
    };
  };
}
