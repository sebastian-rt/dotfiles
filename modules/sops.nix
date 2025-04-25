{pkgs, ...}: {
  sops = {
    defaultSopsFile = ../secrets.yaml;
    age = {
      keyFile = "/persist/user/home/sebastian/.config/sops/age/keys.txt";
    };
    secrets."user_passwords/sebastian".neededForUsers = true;
    secrets."user_passwords/root".neededForUsers = true;
  };

  home-manager.users.sebastian.home = {
    packages = with pkgs; [
      age
      sops
    ];
  };
}
