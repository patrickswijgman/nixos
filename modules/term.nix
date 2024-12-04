{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 10;
            y = 10;
          };
        };
        keyboard.bindings = [
          {
            key = "N";
            mods = "Control|Shift";
            action = "SpawnNewInstance";
          }
        ];
      };
    };

    programs.spotify-player = {
      enable = true;
      settings = {
        enable_notify = false;
        device = {
          volume = 100;
          normalization = true;
        };
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
    };

    programs.bat = {
      enable = true;
    };

    programs.htop = {
      enable = true;
    };

    home.packages = with pkgs; [
      zip
      unzip
      tree
      gdu
      openvpn
      slides
      graph-easy
      cowsay
    ];
  };
}
