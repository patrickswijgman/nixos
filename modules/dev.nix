{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    home.packages = with pkgs; [
      # Nix
      nil
      nixfmt-rfc-style

      # Rust
      rustc
      cargo
      gcc # C compiler
      rust-analyzer

      # Go
      go
      gopls
      golangci-lint-langserver

      # Lua
      lua-language-server
      stylua

      # Web
      nodejs_20
      typescript
      typescript-language-server
      tailwindcss-language-server
      vscode-langservers-extracted # Eslint, HTML, CSS, JSON, YAML, Markdown
      prettierd

      # Markdown
      mkdocs
    ];
  };
}
