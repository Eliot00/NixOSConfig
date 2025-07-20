{ pkgs, ... }:
{
  imports = [
    ../../modules/emacs
  ];

  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    tdesktop
    fractal

    anki
    mpv # anki dependent on it

    vlc

    rust-analyzer
    typescript-language-server

    nodePackages.pnpm

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
    themeFile = "everforest_light_soft";
    font = {
      name = "Maple Mono NF";
      size = 18;
    };
    shellIntegration = {
      enableFishIntegration = true;
    };
    keybindings = {
      "alt+t" = "new_tab_with_cwd";
      "alt+enter" = "new_window_with_cwd";
      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";
      "alt+5" = "goto_tab 5";
      "alt+6" = "goto_tab 6";
      "alt+7" = "goto_tab 7";
      "alt+8" = "goto_tab 8";
      "alt+9" = "goto_tab 9";
    };
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

  home.sessionVariables = {
    SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt";
  };
}
