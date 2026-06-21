{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs31-pgtk;
  };

}
