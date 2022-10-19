{ pkgs, ... }:
{
  home.stateVersion = "21.11";
  home.packages = with pkgs; [
    logseq
    tdesktop
    anki-bin
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
  manual.manpages.enable = false;
}
