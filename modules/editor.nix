{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    programs.zed-editor = {
      enable = true;
      # https://zed.dev/docs/configuring-zed#settings
      userSettings = {
        theme = "Fleet Dark";
        auto_update = false;
        vim_mode = true;
        tab_bar = {
          show = true;
          show_nav_history_buttons = false;
        };
        tabs = {
          close_position = "right";
          file_icons = false;
          git_status = false;
          activate_on_close = "history";
        };
        soft_wrap = "editor_width";
        wrap_guides = [
          80
          120
        ];
        terminal = {
          font_family = "FiraCode Nerd Font";
        };
        languages = {
          HTML = {
            formatter = "prettier";
            format_on_save = "on";
          };
          Markdown = {
            formatter = "prettier";
            format_on_save = "on";
          };
        };
        lsp = {
          vtsls = {
            settings = {
              typescript = {
                preferences = {
                  importModuleSpecifier = "non-relative";
                  importModuleSpecifierEnding = "js";
                };
              };
            };
          };
        };
      };
      # https://zed.dev/docs/key-bindings
      userKeymaps = { };
      # https://github.com/zed-industries/extensions/tree/main/extensions
      extensions = [
        "fleet-themes"
        "nix"
        "dockerfile"
        "docker-compose"
        "html"
        "deno"
        "ruff"
      ];
    };

    home.sessionVariables = {
      EDITOR = "zeditor";
    };
  };

  # Enable dynamic execution of binaries, e.g. Node to install language servers.
  programs.nix-ld.enable = true;
}
