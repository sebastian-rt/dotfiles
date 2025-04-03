{...}: {
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["sebastian"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  environment.persistence."/persist".directories = ["/var/lib/libvirt"];
}
