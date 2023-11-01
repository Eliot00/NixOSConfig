{ config, pkgs, lib, ... }:

{

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.gpg.enable = true;

  programs.git = {
    enable = true;
    userName = "Elliot";
    userEmail = "hack00mind@gmail.com";
    aliases = {
      co = "checkout";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %C(bold blue)%s%Creset %Cgreen(%cr) <%an>%Creset' --abbrev-commit --date=relative";
    };
    extraConfig = {
      # Sign all commits using ssh key
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    cascadia-code
    lxgw-wenkai
    (nerdfonts.override { fonts = [ "CascadiaCode" ]; })

    commit-formatter
    dhall
    htop
    ots
    ripgrep
    tree
    watchman
  ];

  programs.fish.enable = true;
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.gitui = {
    enable = true;
    keyConfig = ''
      (
      open_help: Some(( code: F(1), modifiers: ( bits: 0,),)),

      move_left: Some(( code: Char('h'), modifiers: ( bits: 0,),)),
      move_right: Some(( code: Char('l'), modifiers: ( bits: 0,),)),
      move_up: Some(( code: Char('k'), modifiers: ( bits: 0,),)),
      move_down: Some(( code: Char('j'), modifiers: ( bits: 0,),)),

      popup_up: Some(( code: Char('p'), modifiers: ( bits: 2,),)),
      popup_down: Some(( code: Char('n'), modifiers: ( bits: 2,),)),
      page_up: Some(( code: Char('b'), modifiers: ( bits: 2,),)),
      page_down: Some(( code: Char('f'), modifiers: ( bits: 2,),)),
      home: Some(( code: Char('g'), modifiers: ( bits: 0,),)),
      end: Some(( code: Char('G'), modifiers: ( bits: 1,),)),
      shift_up: Some(( code: Char('K'), modifiers: ( bits: 1,),)),
      shift_down: Some(( code: Char('J'), modifiers: ( bits: 1,),)),

      edit_file: Some(( code: Char('I'), modifiers: ( bits: 1,),)),

      status_reset_item: Some(( code: Char('U'), modifiers: ( bits: 1,),)),

      diff_reset_lines: Some(( code: Char('u'), modifiers: ( bits: 0,),)),
      diff_stage_lines: Some(( code: Char('s'), modifiers: ( bits: 0,),)),

      stashing_save: Some(( code: Char('w'), modifiers: ( bits: 0,),)),
      stashing_toggle_index: Some(( code: Char('m'), modifiers: ( bits: 0,),)),

      stash_open: Some(( code: Char('l'), modifiers: ( bits: 0,),)),

      abort_merge: Some(( code: Char('M'), modifiers: ( bits: 1,),)),
      )
    '';
  };

  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
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
