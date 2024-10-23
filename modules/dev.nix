{ config, pkgs, ... }:

let
  scls = pkgs.callPackage ./custom/simple-completion-language-server.nix { };
  vlse = pkgs.callPackage ./custom/vscode-langservers-extracted.nix { };
in
{
  home-manager.users.patrick = {
    programs.go = {
      enable = true;
    };

    home.packages = with pkgs; [
      # Nix
      nil
      nixfmt-rfc-style

      # Go
      gopls
      golangci-lint
      golangci-lint-langserver

      # Rust
      rustc
      cargo

      # Python
      pyright
      ruff

      # Web
      nodejs_20
      nodePackages.prettier
      typescript-language-server
      tailwindcss-language-server
      (vlse)
      deno

      # Text and config files
      marksman
      yaml-language-server
      taplo
      typos-lsp
      (scls)

      # Docker
      docker-compose-language-service
      dockerfile-language-server-nodejs
    ];
  };
}
