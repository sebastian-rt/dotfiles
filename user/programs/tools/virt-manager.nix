{...}: {
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["sebastian"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  environment.persistence."/persist/system".directories = ["/var/lib/libvirt"];
}
