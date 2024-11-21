{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    # https://nix-community.github.io/nixvim/
    # https://nix-community.github.io/nixvim/search/
    programs.nixvim = {
      enable = true;

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "macchiato";
        };
      };

      plugins = {
        web-devicons = {
          enable = true;
        };

        telescope = {
          enable = true;
        };

        neo-tree = {
          enable = true;
          # Fix: some nested options are not renamed to snake_case equivalent, using extraOptions instead.
          extraOptions = {
            enable_diagnostics = false;
            enable_git_status = false;
            popup_border_style = "single";
            window = {
              position = "float";
            };
            filesystem = {
              follow_current_file = {
                enabled = true;
                leave_dirs_open = true;
              };
              filtered_items = {
                hide_dotfiles = false;
                hide_by_name = [ ".git" ];
              };
            };
            sources = [ "filesystem" ];
          };
        };

        treesitter = {
          enable = true;
          settings = {
            highlight.enable = true;
          };
        };

        copilot-vim = {
          enable = true;
        };

        zen-mode = {
          enable = true;
        };

        auto-session = {
          enable = true;
        };

        conform-nvim = {
          enable = true;
          settings = {
            formatters_by_ft = {
              html = [ "prettier" ];
              css = [ "prettier" ];
              javascript = [ "prettier" ];
              javascriptreact = [ "prettier" ];
              typescript = [ "prettier" ];
              typescriptreact = [ "prettier" ];
              json = [ "prettier" ];
              jsonc = [ "prettier" ];
              yaml = [ "prettier" ];
              markdown = [ "prettier" ];
              nix = [ "nixfmt" ];
              _ = [ "trim_whitespace" ];
            };
            format_on_save = {
              lsp_format = "fallback";
            };
          };
        };

        lsp = {
          enable = true;
          servers = {
            nil_ls = {
              enable = true;
            };

            ts_ls = {
              enable = true;
              extraOptions = {
                # https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md#preferences-options
                init_options = {
                  preferences = {
                    importModuleSpecifierPreference = "non-relative";
                    importModuleSpecifierEnding = "js";
                  };
                };
              };
            };

            eslint = {
              enable = true;
            };

            html = {
              enable = true;
            };

            cssls = {
              enable = true;
            };

            tailwindcss = {
              enable = true;
            };

            jsonls = {
              enable = true;
            };

            yamlls = {
              enable = true;
            };

            marksman = {
              enable = true;
            };

            gopls = {
              enable = true;
            };

            golangci_lint_ls = {
              enable = true;
            };

            rust_analyzer = {
              enable = true;
              # installRustc = false;
              # installCargo = false;
            };
          };
          onAttach = ''
            -- Disable semantic tokens as Treesitter is used for syntax highlighting instead.
            client.server_capabilities.semanticTokensProvider = nil
          '';
          keymaps = {
            lspBuf = {
              "<leader>a" = "code_action";
              "<leader>r" = "rename";
            };
          };
        };
      };

      keymaps = [
        {
          key = "<leader>y";
          action = "\"+y";
          mode = [
            "n"
            "v"
          ];
        }
        {
          key = "<leader>p";
          action = "\"+p";
          mode = [
            "n"
            "v"
          ];
        }
        {
          key = "<leader>e";
          action = "<cmd>Neotree filesystem reveal<cr>";
        }
        {
          key = "<leader>f";
          action = "<cmd>Telescope find_files<cr>";
        }
        {
          key = "<leader>g";
          action = "<cmd>Telescope live_grep<cr>";
        }
        {
          key = "<leader>w";
          action = "<cmd>Telescope grep_string<cr>";
        }
        {
          key = "<leader>b";
          action = "<cmd>Telescope buffers<cr>";
        }
        {
          key = "<leader>/";
          action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
        }
        {
          key = "gd";
          action = "<cmd>Telescope lsp_definitions<cr>";
        }
        {
          key = "gr";
          action = "<cmd>Telescope lsp_references<cr>";
        }
        {
          key = "gt";
          action = "<cmd>Telescope lsp_type_definitions<cr>";
        }
        {
          key = "<leader>t";
          action = "<cmd>Telescope lsp_workspace_symbols<cr>";
        }
        {
          key = "<leader>o";
          action = "<cmd>Telescope lsp_document_symbols<cr>";
        }
        {
          key = "<leader>d";
          action = "<cmd>Telescope diagnostics bufnr=0<cr>";
        }
        {
          key = "<leader>s";
          action = "<cmd>Telescope spell_suggest<cr>";
        }
        {
          key = "<leader>h";
          action = "<cmd>Telescope help_tags<cr>";
        }
        {
          key = "<leader>z";
          action = "<cmd>ZenMode<cr>";
        }
        {
          key = "<c-h>";
          action = "<c-w>h";
        }
        {
          key = "<c-j>";
          action = "<c-w>j";
        }
        {
          key = "<c-k>";
          action = "<c-w>k";
        }
        {
          key = "<c-l>";
          action = "<c-w>l";
        }
        {
          key = "<c-tab>";
          action = "<c-w>w";
        }
        {
          key = "<c-q>";
          action = "<c-w>q";
        }
      ];

      globals = {
        mapleader = " ";

        loaded_netrw = true;
        loaded_netrwPlugin = true;
      };

      opts = {
        mouse = "a";
        number = true;
        relativenumber = true;
        cursorline = true;
        signcolumn = "yes";
        colorcolumn = "80,120";
        scrolloff = 8;
        splitright = true;
        splitbelow = true;
        undofile = true;
        swapfile = false;
        backup = false;
        sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions";
        updatetime = 50;
        termguicolors = true;

        showmatch = true;
        hlsearch = false;
        incsearch = true;

        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        autoindent = true;

        completeopt = "menuone,popup,noinsert,noselect";

        spell = true;
        spelllang = "en_us";
        spelloptions = "camel";
        spellfile = "/home/patrick/nixos/runtime/nvim/spell/en.utf-8.add";
      };

      filetype = {
        pattern = {
          ".env" = "properties";
          ".env.*" = "properties";
          ".env.*.local" = "properties";
        };
      };

      autoCmd = [
        {
          callback.__raw = "function() vim.highlight.on_yank() end";
          event = [ "TextYankPost" ];
        }
      ];
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
