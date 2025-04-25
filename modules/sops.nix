{pkgs, ...}: {
  sops = {
    defaultSopsFile = ../secrets.yaml;
    age = {
      keyFile = "/persist/user/home/sebastian/.config/sops/age/keys.txt";
    };
  };

  home-manager.users.sebastian.home = {
    packages = with pkgs; [
      age
      sops
    ];
  };
}
