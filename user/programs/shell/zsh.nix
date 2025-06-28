{username}: {pkgs, ...}: {
  home-manager.users.${username} = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        "cat" = "colorize_cat";
        "cd.." = "cd ..";
        "fixpw" = "systemctl --user restart pipewire pipewire-pulse wireplumber";
        "bwpass" = "bw get password";
      };
      initContent = ''
        if [ -z "$SSH_CONNECTION" ]; then
          echo -e "\e[31m$(${pkgs.nettools}/bin/hostname | ${pkgs.figlet}/bin/figlet -f slant)\e[0m";
        fi
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [
          "sudo"
          "git"
          "tmux"
          "colorize"
        ];
      };
    };
    programs.zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };
    home.packages = with pkgs; [
      chroma # Required for oh-my-zsh 'colorize' plugin
    ];
  };
}
