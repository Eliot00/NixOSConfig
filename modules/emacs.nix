{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = if pkgs.system == "aarch64-darwin" then pkgs.emacs29-macport else pkgs.emacs29;
    extraPackages = epkgs : with epkgs; [
      evil

      # programming
      cape
      consult
      corfu
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

      org-appear
      org-modern
      org-roam
      org-roam-ui
    ];
  };
}
