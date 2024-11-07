{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    # https://nix-community.github.io/nixvim/
    # https://nix-community.github.io/nixvim/search/
    programs.nixvim = {
      enable = true;

      colorschemes.vscode.enable = true;

      plugins = {
        # Comments.
        commentary = {
          enable = true;
        };

        # Surround text with quotes or brackets.
        nvim-surround = {
          enable = true;
        };

        # Icons for other plugins (telescope, neo-tree).
        web-devicons = {
          enable = true;
        };

        # Find things (files, text, buffers, etc).
        telescope = {
          enable = true;
          settings = {
            defaults = {
              # Configure to use ripgrep when searching with grep_string or live_grep.
              vimgrep_arguments = [
                "rg"
                "--follow" # Follow symbolic links.
                "--hidden" # Search for hidden files.
                "--color=never" # Don't use colors, Telescope can't interpret them.
                "--no-heading" # Don't group matches by each file.
                "--with-filename" # Print the file path with the matched lines.
                "--line-number" # Show line numbers.
                "--column" # Show column numbers.
                "--smart-case" # Smart case search.
                # Exclude some patterns from search.
                "--glob=!**/.git/*"
                "--glob=!**/.idea/*"
                "--glob=!**/.vscode/*"
                "--glob=!**/build/*"
                "--glob=!**/dist/*"
                "--glob=!**/yarn.lock"
                "--glob=!**/package-lock.json"
              ];
            };
            pickers = {
              # Configure to use ripgrep when searching for a file.
              find_files = {
                find_command = [
                  "rg"
                  "--files" # List all files.
                  "--hidden" # Search for hidden files.
                  "--sort=path" # Ascending sort by path.
                  "--color=never" # Don't use colors, Telescope can't interpret them.
                  "--smart-case" # Smart case search.
                  # Exclude some patterns from search.
                  "--glob=!**/.git/*"
                  "--glob=!**/.idea/*"
                  "--glob=!**/.vscode/*"
                  "--glob=!**/build/*"
                  "--glob=!**/dist/*"
                  "--glob=!**/yarn.lock"
                  "--glob=!**/package-lock.json"
                ];
              };
            };
          };
        };

        # File explorer.
        neo-tree = {
          enable = true;
          # Fix: some options are not renamed to snake_case equivalent, using extraOptions instead.
          extraOptions = {
            enable_diagnostics = false;
            enable_git_status = false;
            popup_border_style = "single";
            window = {
              position = "left";
              width = 60;
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

        # Syntax highlighting (includes all grammars by default).
        treesitter = {
          enable = true;
          settings = {
            highlight.enable = true;
          };
        };

        # Highlight colors.
        nvim-colorizer = {
          enable = true;
          fileTypes = [
            "html"
            "css"
            "javascript"
            "javascriptreact"
            "typescript"
            "typescriptreact"
          ];
          userDefaultOptions = {
            mode = "background";
            RGB = true;
            RRGGBB = true;
            RRGGBBAA = true;
            rgb_fn = true;
            names = true;
            tailwind = true;
          };
        };

        # Show keymaps in each mode after a short delay.
        which-key = {
          enable = true;
          settings = {
            icons.mappings = false;
            # LSP keymaps (these don't have a description option).
            spec = [
              {
                __unkeyed = "]d";
                desc = "Next diagnostic";
              }
              {
                __unkeyed = "[d";
                desc = "Previous diagnostic";
              }
              {
                __unkeyed = "gh";
                desc = "Open diagnostic float";
              }
              {
                __unkeyed = "K";
                desc = "Hover";
              }
              {
                __unkeyed = "<leader>a";
                desc = "Code action";
              }
              {
                __unkeyed = "<leader>r";
                desc = "Rename";
              }
            ];
          };
        };

        # Enable GitHub Copilot.
        copilot-vim = {
          enable = true;
        };

        # Notifications in the bottom-right for e.g. LSP messages.
        fidget = {
          enable = true;
        };

        # Show buffer tabs at the top.
        bufferline = {
          enable = true;
          settings.options = {
            offsets = [
              {
                filetype = "neo-tree";
                separator = true;
              }
            ];
          };
        };

        # Statusline.
        lualine = {
          enable = true;
          # Fix: empty lists are omitted, using raw Lua instead.
          settings.__raw = ''
            {
              options = {
                disabled_filetypes = { 'neo-tree' }
              },
              sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diagnostics' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { 'filetype' },
                lualine_y = { 'location' },
                lualine_z = {}
              }
            }
          '';
        };

        # Helper for closing buffers without closing the window.
        vim-bbye = {
          enable = true;
        };

        # Completion engine for different sources such as LSP and buffer.
        cmp = {
          enable = true;
          autoEnableSources = true; # Auto-enable corresponding cmp plugin for each source.
          settings = {
            snippet = {
              expand = ''
                function(args)
                  vim.snippet.expand(args.body)
                end
              '';
            };
            mapping.__raw = ''
              cmp.mapping.preset.insert({
                ["<up>"]      = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ["<down>"]    = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ["<cr>"]      = cmp.mapping.confirm({ select = true }),
                ["<c-n>"]     = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ["<c-p>"]     = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ["<c-y>"]     = cmp.mapping.confirm({ select = true }),
                ["<c-space>"] = cmp.mapping.complete(),
                ["<c-d>"]     = cmp.mapping.scroll_docs(-4),
                ["<c-u>"]     = cmp.mapping.scroll_docs(4),
              })
            '';
            sources = [
              {
                name = "nvim_lsp";
                group_index = 1;
              }
              {
                name = "buffer";
                group_index = 2;
              }
            ];
          };
          cmdline = {
            "/" = {
              mapping.__raw = ''cmp.mapping.preset.cmdline()'';
              sources = [
                { name = "buffer"; }
              ];
            };
            "?" = {
              mapping.__raw = ''cmp.mapping.preset.cmdline()'';
              sources = [
                { name = "buffer"; }
              ];
            };
            ":" = {
              mapping.__raw = ''cmp.mapping.preset.cmdline()'';
              sources = [
                {
                  name = "path";
                  group_index = 1;
                }
                {
                  name = "cmdline";
                  group_index = 2;
                }
              ];
              matching = {
                disallow_symbol_nonprefix_matching = false;
              };
            };
          };
        };

        # Code formatters.
        conform-nvim = {
          enable = true;
          settings = {
            formatters_by_ft = {
              html = [ "prettierd" ];
              css = [ "prettierd" ];
              javascript = [ "prettierd" ];
              javascriptreact = [ "prettierd" ];
              typescript = [ "prettierd" ];
              typescriptreact = [ "prettierd" ];
              json = [ "prettierd" ];
              jsonc = [ "prettierd" ];
              yaml = [ "prettierd" ];
              markdown = [ "prettierd" ];
              nix = [ "nixfmt" ];
              _ = [ "trim_whitespace" ];
            };
            format_on_save = {
              lsp_format = "fallback";
            };
          };
        };

        # LSP (language servers) settings.
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

            typos_lsp = {
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
              installRustc = false;
              installCargo = false;
            };
          };
          onAttach = ''
            -- Disable semantic tokens as Treesitter is used for syntax highlighting instead.
            client.server_capabilities.semanticTokensProvider = nil
          '';
          keymaps = {
            diagnostic = {
              "]d" = "goto_next";
              "[d" = "goto_prev";
              "gh" = "open_float";
            };
            lspBuf = {
              "K" = "hover";
              "<leader>a" = "code_action";
              "<leader>r" = "rename";
            };
          };
        };
      };

      keymaps = [
        # General.
        {
          key = "<leader>y";
          action = "\"+y";
          options.desc = "Yank to system clipboard";
          mode = [
            "n"
            "v"
          ];
        }
        {
          key = "<leader>p";
          action = "\"+p";
          options.desc = "Paste from system clipboard";
          mode = [
            "n"
            "v"
          ];
        }
        # Explorer.
        {
          key = "<leader>e";
          action = "<cmd>Neotree filesystem reveal<cr>";
          options.desc = "Open file explorer";
        }
        # Telescope.
        {
          key = "<leader>f";
          action = "<cmd>Telescope find_files<cr>";
          options.desc = "List files";
        }
        {
          key = "<leader>g";
          action = "<cmd>Telescope live_grep<cr>";
          options.desc = "Live fuzzy search in workspace";
        }
        {
          key = "<leader>w";
          action = "<cmd>Telescope grep_string<cr>";
          options.desc = "Searches for word under the cursor or selection";
        }
        {
          key = "<leader>b";
          action = "<cmd>Telescope buffers<cr>";
          options.desc = "List buffers";
        }
        {
          key = "<leader>/";
          action = "<cmd>Telescope current_buffer_fuzzy_find<cr>";
          options.desc = "Live fuzzy search in current buffer";
        }
        {
          key = "gd";
          action = "<cmd>Telescope lsp_definitions<cr>";
          options.desc = "Go to definition for word under the cursor";
        }
        {
          key = "gr";
          action = "<cmd>Telescope lsp_references<cr>";
          options.desc = "Lists references for word under the cursor";
        }
        {
          key = "gt";
          action = "<cmd>Telescope lsp_type_definitions<cr>";
          options.desc = "Go to the type definition for word under the cursor";
        }
        {
          key = "<leader>t";
          action = "<cmd>Telescope lsp_workspace_symbols<cr>";
          options.desc = "Lists LSP symbols in workspace";
        }
        {
          key = "<leader>o";
          action = "<cmd>Telescope lsp_document_symbols<cr>";
          options.desc = "Lists LSP symbols in current buffer (document)";
        }
        {
          key = "<leader>d";
          action = "<cmd>Telescope diagnostics bufnr=0<cr>";
          options.desc = "Lists diagnostics in current buffer (document)";
        }
        {
          key = "<leader>h";
          action = "<cmd>Telescope help_tags<cr>";
          options.desc = "Lists help tags";
        }
        {
          key = "<leader>s";
          action = "<cmd>Telescope spell_suggest<cr>";
          options.desc = "Lists spelling suggestions";
        }
        # Misc.
        {
          key = "<leader>?";
          action = "<cmd>WhichKey<cr>";
          options.desc = "Lists available keymaps in current mode";
        }
        # Window shortcuts.
        {
          key = "<c-h>";
          action = "<c-w>h";
          options.desc = "Go to the left window";
        }
        {
          key = "<c-j>";
          action = "<c-w>j";
          options.desc = "Go to the down window";
        }
        {
          key = "<c-k>";
          action = "<c-w>k";
          options.desc = "Go to the up window";
        }
        {
          key = "<c-l>";
          action = "<c-w>l";
          options.desc = "Go to the right window";
        }
        {
          key = "<c-tab>";
          action = "<c-w>w";
          options.desc = "Switch windows";
        }
        {
          key = "<c-q>";
          action = "<c-w>q";
          options.desc = "Close window";
        }
        # Buffer shortcuts.
        {
          key = "<a-h>";
          action = "<cmd>bprevious<cr>";
          options.desc = "Previous buffer";
        }
        {
          key = "<a-l>";
          action = "<cmd>bnext<cr>";
          options.desc = "Next buffer";
        }
        {
          key = "<a-tab>";
          action = "<c-6>";
          options.desc = "Switch buffers";
        }
        {
          key = "<a-q>";
          action = "<cmd>Bwipeout<cr>";
          options.desc = "Close buffer";
        }
      ];

      globals = {
        # Set <leader> key to space.
        mapleader = " ";

        # Disable netrw in favor of an explorer plugin like neo-tree.
        loaded_netrw = true;
        loaded_netrwPlugin = true;
      };

      opts = {
        # Enable the mouse.
        mouse = "a";

        # Spot the cursor more easily by highlighting the current line.
        cursorline = true;

        # Show a "max line length" column.
        colorcolumn = "80,120";

        # Show line numbers.
        number = true;
        relativenumber = true;

        # Cursor scroll offset.
        scrolloff = 8;

        # Enable the sign column on the left to show things like warning and errors symbols.
        signcolumn = "yes";

        # Search settings.
        showmatch = true;
        hlsearch = false;
        incsearch = true;

        # Default indentation settings.
        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        autoindent = true;

        # Keep undo history between sessions.
        undofile = true;

        # Disable swap file, it's annoying.
        swapfile = false;
        backup = false;

        # Change default splitting behavior.
        splitright = true;
        splitbelow = true;

        # Update time for CursorHold autocommand event.
        updatetime = 50;

        # Enable 24-bit RGB colors, requires compatible terminal.
        termguicolors = true;

        # Enable spell checking.
        spell = true;
        spelllang = "en_us";
        spelloptions = "camel";
        spellfile = "/home/patrick/nixos/runtime/nvim/spell/en.utf-8.add";
      };
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
