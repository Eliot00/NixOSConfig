{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsWithPackagesFromUsePackage {
      config = ./README.org;
      defaultInitFile = true;
      package = if pkgs.system == "aarch64-darwin"
                   then pkgs.emacs-macport
                   else pkgs.emacs-pgtk;
      alwaysEnsure = true;
      alwaysTangle = true;
    };
  };
}
