{ pkgs, ... }:
{
  imports = [
    ../../modules/emacs.nix
  ];

  home.stateVersion = "21.11";
  home.packages = with pkgs; [
    tdesktop
    kdePackages.neochat

    anki-bin
    mpv # anki dependent on it

    vlc
    kdePackages.kate

    wezterm

    yarn
    nodePackages.pnpm

    # test unstable wayland ime protocols
    weston

    qbittorrent
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
  programs.kitty = {
    enable = true;
    font = {
      name = "Cascadia Code";
      size = 18;
    };
    theme = "Gruvbox Light Soft";
    shellIntegration = {
      enableFishIntegration = true;
    };
    keybindings = {
      "kitty_mod+t" = "new_tab_with_cwd";
    };
    extraConfig = ''
      # symbol_map
      symbol_map U+4E00-U+9FFF,U+3400-U+4DBF,U+20000-U+2A6DF,U+2A700–U+2B73F,U+2B740–U+2B81F,U+2B820–U+2CEAF,U+F900-U+FAFF,U+2F800-U+2FA1F LXGW WenKai
    '';
  };
}
