{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  
  users.users.joshua = {
    isNormalUser = true;
    home = "/home/joshua";
    description = "Joshua Seiger-Eatwell";
    extraGroups = ["wheel" "networkmanager"];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "thinkpad"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Copenhagen";

  i18n.defaultLocale = "en_DK.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  services.xserver.enable = true;
  services.xserver.layout = "dk";
  services.xserver.xkbOptions = "caps:escape";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  services.xserver.libinput.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    firefox
    gnome.gnome-tweaks
    darktable
    signal-desktop
    calibre
    vscode
    gimp
    keepassxc
  ];

  services.openssh.enable = true;
  system.copySystemConfiguration = true;
  system.stateVersion = "22.11"; # Did you read the comment?

}

