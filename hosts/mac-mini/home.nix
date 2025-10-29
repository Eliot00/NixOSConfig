{ config, pkgs, lib, ... }:

{
  imports = [
  ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.gpg.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Elliot";
        email = "hack00mind@gmail.com";
      };
      alias = {
        co = "checkout";
        lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %C(bold blue)%s%Creset %Cgreen(%cr) <%an>%Creset' --abbrev-commit --date=relative";
      };
    };
    signing = {
      format = "ssh";
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    commit-formatter
    htop
    ripgrep
    tree
  ];

  programs.fish.enable = true;
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/elliot/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "vim";
  };
}
