{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "autumn_night";
      editor = {
        cursorline = true;
        line-number = "relative";
        bufferline = "multiple";
        shell = [
          "fish"
          "-c"
        ];
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        file-picker = {
          hidden = false;
        };
        lsp = {
          display-messages = true;
        };
        soft-wrap = {
          enable = true;
          max-wrap = 25;
          max-indent-retain = 0;
        };
      };
      keys.normal = {
        "C-h" = "jump_view_left";
        "C-j" = "jump_view_down";
        "C-k" = "jump_view_up";
        "C-l" = "jump_view_right";
        "C-a" = "select_all";
        "C-r" = "redo";
        "A-h" = "goto_previous_buffer";
        "A-l" = "goto_next_buffer";
        "A-q" = ":buffer-close";
        "A-tab" = "goto_last_accessed_file";
        "q" = "no_op";
        "Q" = "no_op";
        "x" = "select_line_below";
        "X" = "select_line_above";
        "Y" = [
          "extend_to_line_bounds"
          "yank"
        ];
        "D" = [
          "extend_to_line_bounds"
          "delete_selection"
        ];
        "esc" = [
          "collapse_selection"
          "keep_primary_selection"
        ];
      };
      keys.insert = {
        "esc" = [
          "collapse_selection"
          "normal_mode"
        ];
      };
      keys.select = {
        "C-d" = [
          "search_selection"
          "extend_search_next"
        ];
        "esc" = [
          "collapse_selection"
          "keep_primary_selection"
          "normal_mode"
        ];
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "nixfmt";
      }
      {
        name = "typescript";
        language-servers = [
          "typescript-language-server"
          "vscode-eslint-language-server"
        ];
        formatter = {
          command = "prettierd";
          args = [
            "--parser"
            "typescript"
          ];
        };
        auto-format = true;
      }
      {
        name = "tsx";
        language-servers = [
          "typescript-language-server"
          "vscode-eslint-language-server"
          "tailwindcss-language-server"
        ];
        formatter = {
          command = "prettierd";
          args = [
            "--parser"
            "typescript"
          ];
        };
        auto-format = true;
      }
    ];
    languages.language-server.typescript-language-server = {
      config.preferences.importModuleSpecifierPreference = "non-relative";
      config.preferences.importModuleSpecifierEnding = "js";
    };
  };

  home.packages = with pkgs; [
    nil
    nixfmt-rfc-style
    typescript-language-server
    vscode-langservers-extracted
    tailwindcss-language-server
    prettierd
  ];

  home.sessionVariables = {
    EDITOR = "hx";
  };
}
