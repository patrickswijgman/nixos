{ config, pkgs, ... }:

let
  vscode-langservers-extracted_4-8-0 = pkgs.vscode-langservers-extracted.overrideAttrs (oldAttrs: {
    version = "4.8.0";
  });
in
{
  programs.go = {
    enable = true;
  };

  home.packages = with pkgs; [
    nil
    nixfmt-rfc-style

    gopls
    golangci-lint
    golangci-lint-langserver

    nodejs_20

    typescript-language-server
    tailwindcss-language-server
    vscode-langservers-extracted_4-8-0

    marksman
    yaml-language-server

    docker-compose-language-service
    dockerfile-language-server-nodejs

    aseprite
  ];
}
