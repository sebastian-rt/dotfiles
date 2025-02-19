{pkgs, ...}: {
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  users.users.sebastian.extraGroups = ["docker"];
}
