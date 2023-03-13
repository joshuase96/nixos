{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
  
  users.users.joshua = {
    isNormalUser = true;
    home = "/home/joshua";
    description = "Joshua Seiger-Eatwell";
    extraGroups = ["wheel" "networkmanager"];
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "thinkpad";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Copenhagen";

  i18n.defaultLocale = "en_DK.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  services = {
    xserver = {
      enable = true;
      layout = "dk";
      xkbOptions = "caps:escape";
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      libinput.enable = true;
    };

    openssh.enable = true;
  };

  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiIntel
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    git
    cmus
    wget
    firefox
    gnome.gnome-tweaks
    darktable
    signal-desktop
    calibre
    vscode
    gimp
    keepassxc
    libreoffice
  ];

  system = {
    copySystemConfiguration = true;
    stateVersion = "22.11";
  };
}
