{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
  };

  programs.lf = {
    enable = true;
  };

  programs.lazygit = {
    enable = true;
  };

  programs.ripgrep = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
  };

  programs.htop = {
    enable = true;
  };

  home.packages = with pkgs; [
    gdu
  ];
}
