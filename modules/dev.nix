{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    programs.go = {
      enable = true;
    };

    home.packages = with pkgs; [
      # Nix
      nixfmt-rfc-style

      # Rust
      rustc
      cargo
      gcc # C compiler

      # Web
      nodejs_20
      prettierd
      deno

      # Markdown
      mkdocs
    ];
  };
}
