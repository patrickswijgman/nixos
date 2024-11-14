{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
      shellAliases = {
        lg = "lazygit";
      };
      shellAbbrs = {
        gc = "git checkout";
        gb = "git checkout -b";
        gp = "git pull";
        gP = "git push";
        ga = "git add .";
        gm = "git commit -m";
        gma = "git commit --amend";
        gd = "git diff";
        gl = "git log";
        gs = "git status";
        gr = "git rebase -i";
        gra = "git rebase --abort";
        grc = "git rebase --continue";
        ns = "nix-shell --run fish -p";
      };
    };

    programs.oh-my-posh = {
      enable = true;
      settings = {
        version = 2;
        final_space = true;
        disable_notice = true;
        blocks = [
          {
            type = "prompt";
            alignment = "left";
            segments = [
              {
                type = "status";
                style = "plain";
                foreground = "red";
                template = "{{ .String }}";
                properties = {
                  status_template = "last command failed with exit code {{ .Code }}: {{ reason .Code }}";
                };
              }
            ];
          }
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
                type = "git";
                style = "plain";
                foreground = "cyan";
                template = " {{ .HEAD }}<yellow>{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }}{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}</>";
                properties = {
                  branch_icon = "";
                  commit_icon = "@";
                  fetch_status = true;
                };
              }
              {
                type = "node";
                style = "plain";
                foreground = "green";
                template = " Node {{ .Full }}";
              }
              {
                type = "nix-shell";
                style = "plain";
                foreground = "yellow";
                template = " (nix-shell)";
              }
            ];
          }
          {
            type = "prompt";
            alignment = "left";
            newline = true;
            segments = [
              {
                type = "text";
                style = "plain";
                foreground_templates = [
                  "{{if gt .Code 0}}red{{end}}"
                  "{{if eq .Code 0}}green{{end}}"
                ];
                template = "❯";
              }
            ];
          }
          {
            type = "rprompt";
            segments = [
              {
                type = "executiontime";
                style = "plain";
                foreground = "yellow";
                background = "transparent";
                template = "{{ .FormattedMs }}";
              }
            ];
          }
        ];
        transient_prompt = {
          foreground_templates = [
            "{{if gt .Code 0}}red{{end}}"
            "{{if eq .Code 0}}green{{end}}"
          ];
          template = "❯ ";
        };
      };
    };

    programs.keychain = {
      enable = true;
      keys = [
        "~/.ssh/id_ed25519"
      ];
    };
  };

  # Enable fish on system level as well to disable the shell warning.
  programs.fish.enable = true;

  # Set default shell.
  users.users.patrick = {
    shell = pkgs.fish;
  };
}
