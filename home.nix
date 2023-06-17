{ pkgs, elliot-vim, ... }:
{
  imports = [
    elliot-vim.homeManagerModules.vim-config
  ];

  home.stateVersion = "21.11";
  home.packages = with pkgs; [
    logseq
    tdesktop

    anki-bin
    mpv # anki dependent on it

    vlc
    libsForQt5.kate
    android-studio

    wezterm

    yarn
    nodePackages.pnpm
  ];
  programs.git = {
    enable = true;
    userName = "Elliot";
    userEmail = "hack00mind@gmail.com";
    signing = {
      signByDefault = true;
      key = "D66320252AADEFFC";
    };
    aliases = {
      co = "checkout";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --";
    };
    extraConfig = {
      safe = {
        directory = [
          "/etc/nixos"
        ];
      };
    };
  };
  programs.obs-studio.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.fish.enable = true;

  programs.emacs = {
    enable = true;
    extraPackages = epkgs : with epkgs; [
      use-package

      evil

      # programming
      company
      company-box
      consult
      flycheck
      magit
      marginalia
      orderless
      vertico
      consult
      eglot
      rust-mode
      haskell-mode

      doom-modeline
      ef-themes

      org-appear
      org-modern
      org-roam
      org-roam-ui

      ement
    ];
  };
}
