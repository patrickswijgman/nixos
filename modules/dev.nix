{ config, pkgs, ... }:

let
  scls = pkgs.callPackage ./custom/scls.nix { };
  vscode-langservers-extracted = pkgs.callPackage ./custom/vscode-langservers-extracted.nix { };
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
      (vscode-langservers-extracted)

      # Text and config files
      marksman
      yaml-language-server
      typos-lsp
      (scls)

      # Docker
      docker-compose-language-service
      dockerfile-language-server-nodejs
    ];
  };
}
