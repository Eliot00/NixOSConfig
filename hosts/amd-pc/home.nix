{ pkgs, ... }:
{
  imports = [
    ../../modules/emacs.nix
  ];

  home.stateVersion = "21.11";
  home.packages = with pkgs; [
    tdesktop

    anki-bin
    mpv # anki dependent on it

    vlc
    libsForQt5.kate

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
    extraConfig = ''
      # symbol_map
      symbol_map U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0C8,U+E0CA,U+E0CC-U+E0D2,U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E6AD,U+E700-U+E7BC,U+E7C4-U+E7C5,U+EA60-U+EA88,U+EA8A-U+EA8C,U+EA8F-U+EAC7,U+EAC9,U+EACC-U+EAFA,U+EAFC-U+EB09,U+EB0B-U+EB4E,U+EB50-U+EBEB,U+F000-U+F00E,U+F010-U+F01E,U+F021-U+F03E,U+F040-U+F04E,U+F050-U+F05E,U+F060-U+F06E,U+F070-U+F07E,U+F080-U+F08E,U+F090-U+F09E,U+F0A0-U+F0AE,U+F0B0-U+F0B2,U+F0C0-U+F0CE,U+F0D0-U+F0DE,U+F0E0-U+F0EE,U+F0F0-U+F0FE,U+F100-U+F10E,U+F110-U+F115,U+F118-U+F11E,U+F120-U+F12E,U+F130-U+F13E,U+F140-U+F14E,U+F150-U+F15E,U+F160-U+F16E,U+F170-U+F17E,U+F180-U+F18E,U+F190-U+F19E,U+F1A0-U+F1AE,U+F1B0-U+F1BE,U+F1C0-U+F1CE,U+F1D0-U+F1DE,U+F1E0-U+F1EE,U+F1F0-U+F1FE,U+F200-U+F20E,U+F210-U+F21E,U+F221-U+F22D,U+F230-U+F23E,U+F240-U+F24E,U+F250-U+F25E,U+F260-U+F26E,U+F270-U+F27E,U+F280-U+F28E,U+F290-U+F29E,U+F2A0-U+F2AE,U+F2B0-U+F2BE,U+F2C0-U+F2CE,U+F2D0-U+F2DE,U+F2E0,U+F300-U+F32F,U+F400-U+F533,U+F0001-U+F012E,U+F0131-U+F0205,U+F0207-U+F02D0,U+F02D2-U+F02D4,U+F02D6-U+F02F4,U+F02F6-U+F0386,U+F0388-U+F043C,U+F043E-U+F05CC,U+F05CE-U+F0AF5,U+F0AF7-U+F0AF8,U+F0AFA-U+F0AFB,U+F0AFD-U+F0B02,U+F0B04,U+F0B06-U+F0C15,U+F0C18-U+F1AF0 CaskaydiaCove Nerd Font Mono
      symbol_map U+4E00-U+9FFF,U+3400-U+4DBF,U+20000-U+2A6DF,U+2A700–U+2B73F,U+2B740–U+2B81F,U+2B820–U+2CEAF,U+F900-U+FAFF,U+2F800-U+2FA1F LXGW WenKai
    '';
  };
}
