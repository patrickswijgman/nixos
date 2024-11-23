{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    home.packages = with pkgs; [
      # Nix
      nixfmt-rfc-style

      # Rust
      rustc
      cargo
      gcc # C compiler

      # Go
      go
      golangci-lint

      # Lua
      stylua

      # Web
      nodejs_20
      nodePackages.prettier
      typescript

      # Markdown
      mkdocs
    ];
  };
}
