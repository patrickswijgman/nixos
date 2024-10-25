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

    programs.lf = {
      enable = true;
      settings = {
        hidden = true;
        shell = "fish";
      };
      previewer.source = pkgs.writeShellScript "pv.sh" ''
        #!/bin/sh
        case "$1" in
            *.tar*) tar -tf "$1";;
            *.zip) unzip -l "$1";;
            *) bat "$1";;
        esac
      '';
    };

    programs.lazygit = {
      enable = true;
    };

    programs.ripgrep = {
      enable = true;
    };

    programs.fzf = {
      enable = true;
      defaultOptions = [




      "--ansi"]
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
      slides
      unzip
      tree
      gdu
      openvpn
    ];
  };
}
