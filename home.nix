{ pkgs, ... }:
{
  home.packages = with pkgs; [
    logseq
    tdesktop
    anki-bin
    transmission-qt
    vlc

    yarn
    nodePackages.pnpm
  ];
  programs.git = {
    enable = true;
    userName = "Elliot";
    userEmail = "hack00mind@gmail.com";
    signing = {
      signByDefault = true;
      key = "Elliot (My Github GPG) <hack00mind@gmail.com>";
    };
    aliases = {
      co = "checkout";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --";
    };
  };
  programs.obs-studio.enable = true;
}
