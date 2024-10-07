{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
      shellAbbrs = {
        ns = "nix-shell --run fish -p";
        lg = "lazygit";
      };
    };

    programs.oh-my-posh = {
      enable = true;
      settings = {
        version = 2;
        final_space = true;
        blocks = [
          {
            type = "prompt";
            alignment = "left";
            newline = true;
            segments = [
              {
                type = "path";
                style = "plain";
                foreground = "blue";
                template = "{{ .Path }}";
                properties = {
                  style = "full";
                };
              }
              {
                type = "text";
                style = "plain";
                foreground = "magenta";
                template = "$";
              }
            ];
          }
        ];
      };
    };

    programs.keychain = {
      enable = true;
      keys = [
        "~/.ssh/id_ed25519"
      ];
    };

    home.sessionVariables = {
      SHELL = "fish";
    };
  };

  # Enable fish on system level as well to disable the shell warning.
  programs.fish.enable = true;

  # Set default shell.
  users.users.patrick = {
    shell = pkgs.fish;
  };
}
