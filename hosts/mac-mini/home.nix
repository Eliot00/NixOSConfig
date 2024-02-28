{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/emacs.nix
  ];

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
    htop
    ripgrep
    tree
    swift-format
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
        open_help: Some(( code: F(1), modifiers: "")),

        move_left: Some(( code: Char('h'), modifiers: "")),
        move_right: Some(( code: Char('l'), modifiers: "")),
        move_up: Some(( code: Char('k'), modifiers: "")),
        move_down: Some(( code: Char('j'), modifiers: "")),

        popup_up: Some(( code: Char('p'), modifiers: "CONTROL")),
        popup_down: Some(( code: Char('n'), modifiers: "CONTROL")),
        page_up: Some(( code: Char('b'), modifiers: "CONTROL")),
        page_down: Some(( code: Char('f'), modifiers: "CONTROL")),
        home: Some(( code: Char('g'), modifiers: "")),
        end: Some(( code: Char('G'), modifiers: "SHIFT")),
        shift_up: Some(( code: Char('K'), modifiers: "SHIFT")),
        shift_down: Some(( code: Char('J'), modifiers: "SHIFT")),

        edit_file: Some(( code: Char('I'), modifiers: "SHIFT")),

        status_reset_item: Some(( code: Char('U'), modifiers: "SHIFT")),

        diff_reset_lines: Some(( code: Char('u'), modifiers: "")),
        diff_stage_lines: Some(( code: Char('s'), modifiers: "")),

        stashing_save: Some(( code: Char('w'), modifiers: "")),
        stashing_toggle_index: Some(( code: Char('m'), modifiers: "")),

        stash_open: Some(( code: Char('l'), modifiers: "")),

        abort_merge: Some(( code: Char('M'), modifiers: "SHIFT")),
      )
    '';
    theme = ''
      (
        selected_tab: Some(Reset),
        command_fg: Some(Rgb(76, 79, 105)),
        selection_bg: Some(Rgb(172, 176, 190)),
        selection_fg: Some(Rgb(76, 79, 105)),
        cmdbar_bg: Some(Rgb(230, 233, 239)),
        cmdbar_extra_lines_bg: Some(Rgb(230, 233, 239)),
        disabled_fg: Some(Rgb(140, 143, 161)),
        diff_line_add: Some(Rgb(64, 160, 43)),
        diff_line_delete: Some(Rgb(210, 15, 57)),
        diff_file_added: Some(Rgb(223, 142, 29)),
        diff_file_removed: Some(Rgb(230, 69, 83)),
        diff_file_moved: Some(Rgb(136, 57, 239)),
        diff_file_modified: Some(Rgb(254, 100, 11)),
        commit_hash: Some(Rgb(114, 135, 253)),
        commit_time: Some(Rgb(92, 95, 119)),
        commit_author: Some(Rgb(32, 159, 181)),
        danger_fg: Some(Rgb(210, 15, 57)),
        push_gauge_bg: Some(Rgb(30, 102, 245)),
        push_gauge_fg: Some(Rgb(239, 241, 245)),
        tag_fg: Some(Rgb(220, 138, 120)),
        branch_fg: Some(Rgb(23, 146, 153))
      )
    '';
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
    PDM_VENV_BACKEND = "venv";
  };
}
