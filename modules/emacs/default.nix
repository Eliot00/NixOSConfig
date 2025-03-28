{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./README.org;
      defaultInitFile = true;
      package = if pkgs.system == "aarch64-darwin"
                   then pkgs.emacs
                   else pkgs.emacs-pgtk;
      alwaysEnsure = true;
      alwaysTangle = true;
      extraEmacsPackages = epkgs: if pkgs.system == "aarch64-darwin"
                                     then [ epkgs."exec-path-from-shell" ]
                                     else [];
    };
  };
  home.file = {
    ".emacs.d/early-init.el".source = ./early-init.el;
  };
}
