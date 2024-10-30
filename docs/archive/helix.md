# Helix

### Custom package

```nix
{ pkgs, lib, ... }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "helix";
  version = "unstable";

  src = pkgs.fetchFromGitHub {
    owner = "helix-editor";
    repo = pname;
    rev = "761f70d61179f38152e76c1f224589a53b62d00f";
    sha256 = "sha256-amGNilpQ/vohlgerF/5D4QNsXCRbh2H06nmWyz/xyS8=";
  };

  cargoHash = "sha256-AySR2NdGo0GajBF7jJS2IDitXWhcvV3K7Io8ZE21KlM=";

  nativeBuildInputs = [
    pkgs.installShellFiles
  ];

  # Nix package builds do not allow network access, so grammars need to be fetched and built afterwards (requires gcc):
  # hx --grammar fetch
  # hx --grammar build
  env.HELIX_DISABLE_AUTO_GRAMMAR_BUILD = "true";
  env.HELIX_DEFAULT_RUNTIME = "${placeholder "out"}/lib/helix/runtime";

  cargoBuildFlags = [
    "--package=helix-term"
    "--locked"
  ];

  postInstall = ''
    mkdir -p $out/lib/helix
    cp -r runtime $out/lib/helix

    installShellCompletion contrib/completion/hx.{bash,fish,zsh}

    mkdir -p $out/share/{applications,icons/hicolor/256x256/apps}
    cp contrib/Helix.desktop $out/share/applications
    cp contrib/helix.png $out/share/icons/hicolor/256x256/apps
  '';

  meta = with lib; {
    description = "A post-modern modal text editor";
    homepage = "https://helix-editor.com";
    license = licenses.mpl20;
    mainProgram = "hx";
  };
}
```

### Config

```nix
{ config, pkgs, ... }:

let
  helix = pkgs.callPackage ./custom/helix.nix { };
in
{
  home-manager.users.patrick = {
    programs.helix = {
      enable = true;
      package = helix;
      settings = {
        theme = "autumn";

        # https://github.com/helix-editor/helix/blob/master/book/src/editor.md
        editor = {
          scrolloff = 9999;
          cursorline = true;
          line-number = "relative";
          bufferline = "multiple";
          popup-border = "all";
          shell = [
            "fish"
            "-c"
          ];
          end-of-line-diagnostics = "hint";
          inline-diagnostics = {
            cursor-line = "warning";
          };
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
          };
        };

        keys = {
          normal = {
            "C-h" = "jump_view_left";
            "C-j" = "jump_view_down";
            "C-k" = "jump_view_up";
            "C-l" = "jump_view_right";
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
          insert = {
            "esc" = [
              "collapse_selection"
              "normal_mode"
            ];
          };
          select = {
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
      };

      # https://github.com/helix-editor/helix/blob/master/book/src/languages.md
      languages = {
        language-server = {
          scls = {
            command = "simple-completion-language-server";
          };
          typos = {
            command = "typos-lsp";
          };
          typescript-language-server = {
            config.preferences.importModuleSpecifierPreference = "non-relative";
            config.preferences.importModuleSpecifierEnding = "js";
          };
        };
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = "nixfmt";
          }
          {
            name = "python";
            language-servers = [
              "pyright"
              "ruff"
              "typos"
            ];
            auto-format = true;
          }
          {
            name = "typescript";
            language-servers = [
              "typescript-language-server"
              "vscode-eslint-language-server"
              "typos"
            ];
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "typescript"
              ];
            };
          }
          {
            name = "tsx";
            language-servers = [
              "typescript-language-server"
              "vscode-eslint-language-server"
              "tailwindcss-ls"
              "typos"
            ];
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "typescript"
              ];
            };
          }
          {
            name = "javascript";
            language-servers = [
              "typescript-language-server"
              "vscode-eslint-language-server"
              "typos"
            ];
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "typescript"
              ];
            };
          }
          {
            name = "jsx";
            language-servers = [
              "typescript-language-server"
              "vscode-eslint-language-server"
              "tailwindcss-ls"
              "typos"
            ];
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "typescript"
              ];
            };
          }
          {
            name = "html";
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "html"
              ];
            };
          }
          {
            name = "css";
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "css"
              ];
            };
          }
          {
            name = "json";
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "json"
              ];
            };
          }
          {
            name = "yaml";
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "yaml"
              ];
            };
          }
          {
            name = "markdown";
            language-servers = [
              "marksman"
              "typos"
              "scls"
            ];
            auto-format = true;
            formatter = {
              command = "prettier";
              args = [
                "--parser"
                "markdown"
              ];
            };
          }
        ];
      };

      # https://github.com/helix-editor/helix/blob/master/book/src/themes.md#syntax-highlighting
      themes = { };
    };

    home.packages = with pkgs; [
      gcc
    ];

    home.sessionVariables = {
      EDITOR = "hx";
    };
  };
}
```
