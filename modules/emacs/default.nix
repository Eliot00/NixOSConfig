{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./README.org;
      defaultInitFile = true;
      package = if pkgs.system == "aarch64-darwin"
                   then pkgs.emacs-macport
                   else pkgs.emacs29-pgtk;
      alwaysEnsure = true;
      alwaysTangle = true;
    };
    # extraPackages = epkgs : with epkgs; [
    #   evil

    #   # programming
    #   cape
    #   consult
    #   corfu
    #   flycheck
    #   magit
    #   marginalia
    #   orderless
    #   pinyinlib
    #   vertico
    #   yasnippet

    #   doom-modeline
    #   ef-themes

    #   org-appear
    #   org-modern
    #   org-roam
    #   org-roam-ui
    # ];
  };
}