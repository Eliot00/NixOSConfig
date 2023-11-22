{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = if pkgs.system == "aarch64-darwin" then pkgs.emacsMacport else pkgs.emacs;
    extraPackages = epkgs : with epkgs; [
      use-package

      evil

      # programming
      cape
      consult
      corfu
      eglot
      flycheck
      haskell-mode
      magit
      marginalia
      orderless
      pinyinlib
      rust-mode
      vertico
      yasnippet

      doom-modeline
      ef-themes

      org
      org-appear
      org-modern
      org-roam
      org-roam-ui
    ];
  };
}
