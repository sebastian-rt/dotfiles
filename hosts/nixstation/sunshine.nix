{...}: {
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  environment.persistence."/persist/system".users.sebastian.directories = [".config/sunshine"];
}
