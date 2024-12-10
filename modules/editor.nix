{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    # https://nix-community.github.io/nixvim/
    # https://nix-community.github.io/nixvim/search/
    programs.nixvim = {
      enable = true;

      colorschemes.catppuccin.enable = true;

      plugins = {
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
          settings = {
            window = {
              width = 120;
            };
          };
        };

        auto-session = {
          enable = true;
          settings = {
            use_git_branch = true;
          };
        };

        nvim-colorizer = {
          enable = true;
          userDefaultOptions = {
            RGB = true;
            RRGGBB = true;
            RRGGBBAA = true;
            names = false;
            rgb_fn = false;
            hsl_fn = false;
            css = false;
            css_fn = false;
            mode = "background";
          };
        };

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
              go = [ "gofmt" ];
              rust = [ "rustfmt" ];
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
              installRustc = false;
              installCargo = false;
            };
          };

          keymaps = {
            lspBuf = {
              "gd" = "definition";
              "gr" = "references";
              "gt" = "type_definition";
              "go" = "document_symbol";
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
          action = ":Explore<cr>";
        }
        {
          key = "<leader>f";
          action = ":find ";
        }
        {
          key = "<leader>g";
          action = ":grep ";
        }
        {
          key = "<leader>b";
          action = ":buffer ";
        }
        {
          key = "<leader>z";
          action = ":ZenMode<cr>";
        }
        {
          key = "<leader>n";
          action = ":tabnew<cr>";
        }
        {
          key = "<a-h>";
          action = ":tabprev<cr>";
        }
        {
          key = "<a-l>";
          action = ":tabnext<cr>";
        }
        {
          key = "<a-tab>";
          action = "g<tab>";
        }
        {
          key = "<a-q>";
          action = ":tabclose<cr>";
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
        {
          key = "<esc>";
          action = ":nohl<cr>";
          options = {
            noremap = false;
            silent = true;
          };
        }
      ];

      globals = {
        mapleader = " ";

        netrw_banner = 0;
        netrw_keepdir = 0;
        netrw_winsize = 30;
        netrw_liststyle = 3;
        netrw_altfile = 1;
      };

      opts = {
        mouse = "a";
        number = true;
        relativenumber = true;
        cursorline = true;
        signcolumn = "yes";
        colorcolumn = "";
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
        hlsearch = true;
        incsearch = true;

        tabstop = 2;
        softtabstop = 2;
        shiftwidth = 2;
        expandtab = true;
        autoindent = true;

        completeopt = "menuone,popup";

        path = ".,**";
        wildmenu = true;
        wildmode = "full";
        wildoptions = "pum";
        wildignore = "*/node_modules/*,*/.git/*,*/.dropbox/*";
        wildignorecase = true;

        spell = true;
        spelllang = "en_us";
        spelloptions = "camel";
        spellfile = "/home/patrick/nixos/files/nvim/spell/custom.utf-8.add";
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
          event = "TextYankPost";
          command = "lua vim.highlight.on_yank()";
        }
        {
          event = "FileType";
          pattern = "qf,checkhealth";
          command = "setlocal nospell";
        }
        {
          event = "FileType";
          pattern = "netrw";
          command = "setlocal nobuflisted";
        }
      ];
    };

    home.file.".config/nvim" = {
      source = ../files/nvim;
      recursive = true;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
