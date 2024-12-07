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
      rustfmt
      gcc # C compiler
      rust-analyzer

      # Go
      go
      gopls
      golangci-lint
      golangci-lint-langserver

      # Lua
      lua-language-server
      stylua

      # Web
      nodejs_22
      prettierd
      typescript
      typescript-language-server
      vscode-langservers-extracted

      # Other
      font-manager
    ];
  };
}
