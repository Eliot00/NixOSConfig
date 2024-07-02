{ pkgs, ... }:
{
  imports = [
    ../../modules/emacs
  ];

  home.stateVersion = "21.11";
  home.packages = with pkgs; [
    tdesktop
    kdePackages.neochat

    anki-bin
    mpv # anki dependent on it

    vlc
    kdePackages.kate

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
      name = "Cascadia Code NF";
      size = 18;
    };
    shellIntegration = {
      enableFishIntegration = true;
    };
    keybindings = {
      "kitty_mod+t" = "new_tab_with_cwd";
    };
    extraConfig = ''
      # symbol_map
      symbol_map U+4E00-U+9FFF,U+3400-U+4DBF,U+20000-U+2A6DF,U+2A700–U+2B73F,U+2B740–U+2B81F,U+2B820–U+2CEAF,U+F900-U+FAFF,U+2F800-U+2FA1F LXGW WenKai

      ## name:     Catppuccin Kitty Latte
      ## author:   Catppuccin Org
      ## license:  MIT
      ## upstream: https://github.com/catppuccin/kitty/blob/main/themes/latte.conf
      ## blurb:    Soothing pastel theme for the high-spirited!

      # The basic colors
      foreground              #4C4F69
      background              #EFF1F5
      selection_foreground    #EFF1F5
      selection_background    #DC8A78

      # Cursor colors
      cursor                  #DC8A78
      cursor_text_color       #EFF1F5

      # URL underline color when hovering with mouse
      url_color               #DC8A78

      # Kitty window border colors
      active_border_color     #7287FD
      inactive_border_color   #9CA0B0
      bell_border_color       #DF8E1D

      # OS Window titlebar colors
      wayland_titlebar_color  #EFF1F5
      macos_titlebar_color    #EFF1F5

      # Tab bar colors
      active_tab_foreground   #EFF1F5
      active_tab_background   #8839EF
      inactive_tab_foreground #4C4F69
      inactive_tab_background #9CA0B0
      tab_bar_background      #BCC0CC

      # Colors for marks (marked text in the terminal)
      mark1_foreground #EFF1F5
      mark1_background #7287fD
      mark2_foreground #EFF1F5
      mark2_background #8839EF
      mark3_foreground #EFF1F5
      mark3_background #209FB5

      # The 16 terminal colors

      # black
      color0 #5C5F77
      color8 #6C6F85

      # red
      color1 #D20F39
      color9 #D20F39

      # green
      color2  #40A02B
      color10 #40A02B

      # yellow
      color3  #DF8E1D
      color11 #DF8E1D

      # blue
      color4  #1E66F5
      color12 #1E66F5

      # magenta
      color5  #EA76CB
      color13 #EA76CB

      # cyan
      color6  #179299
      color14 #179299

      # white
      color7  #ACB0BE
      color15 #BCC0CC
    '';
  };
}
