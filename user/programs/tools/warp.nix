{username}: {pkgs, ...}: {
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      warp
    ];

    home.file.".config/warp/config.json".text = builtins.toJSON {
      window = {
        width = 460;
        height = 600;
      };
      welcome_window_shown = true;
      rendezvous_server_url = null;
      transit_server_url = null;
      code_length = null;
    };
  };
}
