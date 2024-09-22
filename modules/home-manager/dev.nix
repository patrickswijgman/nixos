{ config, pkgs, ... }:

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
    vscode-langservers-extracted
    tailwindcss-language-server

    marksman
    yaml-language-server

    docker-compose-language-service
    dockerfile-language-server-nodejs
  ];
}
