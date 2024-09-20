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

    typescript-language-server
    vscode-langservers-extracted
    tailwindcss-language-server
  ];
}
