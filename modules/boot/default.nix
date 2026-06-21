{ config, pkgs, lib, ... } @ args:

{
  boot = {
    supportedFilesystems = [
      "ext4"
      "ntfs"
      "fat"
      "vfat"
      "exfat"
    ];

    kernelPackages = pkgs.linuxPackages;

    kernelParams = [
      "nouveau.modeset=0"
    ];

    kernelModules = [
      "kvm-intel"
      # "ch341"
    ];

#     loader ={
#       efi = {
#         canTouchEfiVariables = false;
#         efiSysMountPoint = "/boot";
#       };
#       grub = {
#         enable = true;
#         devices = [ "nodev" ];
#         efiSupport = true;
#         useOSProber = true;
#       };
#     };
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = false;
        useOSProber = true;
        device = "nodev"; # 绕过必须填devices的断言
      };
    };

    #loader = {
    #  systemd-boot.enable = true;
    #  efi.canTouchEfiVariables = true;
    #};
  };

  boot.loader.grub.extraEntries = ''
    menuentry "Arch Linux" {
        insmod part_gpt
        insmod fat
        search --no-floppy --file --set=root /EFI/ARCH/grubx64.efi
        chainloader /EFI/ARCH/grubx64.efi
    }
  '';

}
