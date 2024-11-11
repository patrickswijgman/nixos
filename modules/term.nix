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
      extraOptions = [
        "--hidden"
        "--color=never"
      ];
    };

    programs.fzf = {
      enable = true;
      defaultOptions = [
        "--ansi"
      ];
    };

    programs.bat = {
      enable = true;
      config = {
        color = "always";
      };
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
