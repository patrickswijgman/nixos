{ config, pkgs, ... }:

let
  # Use vscode-langservers-extracted pinned at 4.8.0 for Helix.
  # https://github.com/hrsh7th/vscode-langservers-extracted/commit/859ca87fd778a862ee2c9f4c03017775208d033a#comments
  oldPkgs = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/e89cf1c932006531f454de7d652163a9a5c86668.tar.gz";
    sha256 = "09cbqscrvsd6p0q8rswwxy7pz1p1qbcc8cdkr6p6q8sx0la9r12c";
  }) { inherit (pkgs) system; };
in
{
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

    # Web
    nodejs_20
    typescript-language-server
    tailwindcss-language-server
    (oldPkgs.vscode-langservers-extracted)

    # Text and config files
    marksman
    yaml-language-server

    # Docker
    docker-compose-language-service
    dockerfile-language-server-nodejs

    # General
    typos-lsp

    # Other
    aseprite
  ];
}
