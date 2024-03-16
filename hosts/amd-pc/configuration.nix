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
  networking.nameservers = [
    "119.29.29.29"
    "223.5.5.5"
    "1.1.1.1"
  ];
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
  i18n.defaultLocale = "zh_CN.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [ fcitx5-rime fcitx5-chinese-addons fcitx5-anthy ];
      waylandFrontend = true;
    };
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  services.xserver.displayManager.sddm.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.desktopManager.plasma6.enable = true;
  services.desktopManager.plasma6.enableQt5Integration = false;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

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
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      lxgw-wenkai
      hanazono

      jetbrains-mono
      cascadia-code
      (nerdfonts.override { fonts = [ "JetBrainsMono" "CascadiaCode" ]; })
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrains Mono" "LXGW WenKai" "HanaMinA" "HanaMinB" ];
        sansSerif = [ "DejaVu Sans" "Noto Sans CJK SC" "Noto Sans CJK TC" "HanaMinA" "HanaMinB" ];
        serif = [ "DejaVu Serif" "Noto Serif CJK SC" "Noto Serif CJK TC" "HanaMinA" "HanaMinB" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    fontDir.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    android-studio
    python3
    pdm
    nodejs
    wget
    firefox
    gcc
    ghc
    openssl
    ossutil
    pkg-config
    commit-formatter
    racket
    ripgrep
    stack

    fishPlugins.pure
  ];

  environment.shellAliases = {
    gst = "git status";
    gd = "git diff";
    gdc = "git diff --cached";
    gl = "git pull";
    gp = "git push";
    gco = "git checkout";
    gcm = "git checkout master";
    gb = "git branch";
    gcl = "git config --list";
    gcp = "git cherry-pick";
    ga = "git add";
    gaa = "git add --all";
    gsta = "git stash";
    gstp = "git stash pop";
    gstd = "git stash drop";
    cf = "git cf";
  };

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
    promptInit = ''
      set --universal pure_enable_single_line_prompt true
    '';
    vendor.functions.enable = true;
    vendor.config.enable = true;
  };
  programs.ssh.extraConfig = ''
    Host github.com
    Hostname ssh.github.com
    Port 443
  '';
  programs.vim = {
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
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };
}

