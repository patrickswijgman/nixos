{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "Fira Code";
        };
      };
    };
  };

  home.packages = with pkgs; [
    fira-code
    font-awesome
  ];
}
