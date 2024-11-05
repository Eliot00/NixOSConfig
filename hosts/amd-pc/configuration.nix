# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];

  swapDevices = [{ label = "swap"; }];

  networking.hostName = "elliot-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Asia/Shanghai";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp7s0.useDHCP = true;
  networking.interfaces.wlp6s0.useDHCP = true;
  networking.networkmanager.enable = true;
  services.dae = {
    enable = true;
    configFile = "/home/elliot/.config/dae/config.dae";
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };
  i18n = {
    defaultLocale = "C.UTF-8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [ fcitx5-rime fcitx5-chinese-addons fcitx5-anthy ];
        waylandFrontend = true;
      };
    };
  };

  # services.displayManager.sddm = {
  #   enable = true;
  #   wayland = {
  #     enable = true;
  #   };
  # };
  # services.desktopManager.plasma6.enable = true;
  # services.desktopManager.plasma6.enableQt5Integration = false;
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  hardware.bluetooth.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.elliot = {
    isNormalUser = true;
    description = "Elliot Xu";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      lxgw-wenkai
      hanazono

      jetbrains-mono
      cascadia-code
      (nerdfonts.override { fonts = [ "JetBrainsMono" "FiraCode" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrains Mono" "Noto Sans CJK SC" "Noto Sans CJK TC" ];
        sansSerif = [ "DejaVu Sans" "LXGW WenKai" "HanaMinA" "HanaMinB" ];
        serif = [ "DejaVu Serif" "LXGW WenKai" "HanaMinA" "HanaMinB" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    fontDir.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    android-studio
    bun
    commit-formatter
    devenv
    firefox
    gcc
    nodejs
    ossutil
    pandoc
    pdm
    python3
    racket
    ripgrep
    wget
    fractal
  ];

  environment.shellAliases = import ../../snips/alias.nix;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  programs.kdeconnect.enable = true;
  programs.fish = {
    enable = true;
  };
  programs.ssh.extraConfig = ''
    Host github.com
    Hostname ssh.github.com
    Port 443
  '';
  programs.vim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.vim-full;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      substituters = lib.mkBefore [
        "https://mirrors.bfsu.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      ];
      auto-optimise-store = true;
      trusted-users = [ "root" "elliot" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  home-manager.backupFileExtension = "backup";
}

