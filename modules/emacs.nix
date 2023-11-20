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
      yasnippet
      corfu
      consult
      flycheck
      magit
      marginalia
      orderless
      vertico
      consult
      eglot
      rust-mode
      haskell-mode

      doom-modeline
      ef-themes

      org-appear
      org-modern
      org-roam
      org-roam-ui
    ];
  };
}
