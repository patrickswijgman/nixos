{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

with lib;

let
  oldPkgs = import (inputs.oldPkgs) { inherit (pkgs) system; };
  customPkgs = pkgs.callPackage ./custom.nix { };
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
    (customPkgs.simple-completion-language-server)

    # Docker
    docker-compose-language-service
    dockerfile-language-server-nodejs

    # General
    typos-lsp

    # Other
    aseprite
  ];
}
