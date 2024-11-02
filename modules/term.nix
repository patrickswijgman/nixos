{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    programs.alacritty = {
      enable = true;
      settings = {
        keyboard.bindings = [
          {
            key = "N";
            mods = "Control|Shift";
            action = "SpawnNewInstance";
          }
        ];
      };
    };

    programs.lazygit = {
      enable = true;
    };

    programs.ripgrep = {
      enable = true;
    };

    programs.fd = {
      enable = true;
    };

    programs.fzf = {
      enable = true;
      defaultOptions = [ "--ansi" ];
    };

    programs.bat = {
      enable = true;
      config = {
        theme = "Visual Studio Dark+";
        color = "always";
      };
    };

    programs.htop = {
      enable = true;
    };

    home.packages = with pkgs; [
      pomodoro
      slides
      unzip
      tree
      gdu
      openvpn
    ];
  };
}
