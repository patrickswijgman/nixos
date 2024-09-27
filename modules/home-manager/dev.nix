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
  customPkgs = pkgs.callPackage ./custom.nix { }; # convenience function to pass along default inputs (pkgs, libs)
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

    # Rust
    rustc
    cargo

    # Web
    nodejs_20
    typescript-language-server
    tailwindcss-language-server
    (oldPkgs.vscode-langservers-extracted)

    # Text and config files
    marksman
    yaml-language-server
    typos-lsp
    (customPkgs.simple-completion-language-server)

    # Docker
    docker-compose-language-service
    dockerfile-language-server-nodejs

    # Other
    aseprite
  ];
}
