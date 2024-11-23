{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 5;
            y = 5;
          };
        };
        colors = {
          primary = {
            background = config.colors.bg;
            foreground = config.colors.text;
          };
          normal = {
            black = config.colors.bg;
            red = config.colors.red;
            green = config.colors.green;
            yellow = config.colors.yellow;
            blue = config.colors.blue;
            magenta = config.colors.pink;
            cyan = config.colors.cyan;
            white = config.colors.text;
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
