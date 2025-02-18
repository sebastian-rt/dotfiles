{pkgs, ...}: {
  home-manager.users.sebastian.home = {
    packages = with pkgs; [
      vesktop
    ];
    # file.".config/vesktop/settings.json".text = ''
    #   "discordBranch": "stable",
    #   "minimizeToTray": false,
    #   "arRPC": false,
    #   "customTitleBar": true
    # '';
  };
}
