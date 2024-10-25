{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    programs.go = {
      enable = true;
    };

    home.packages = with pkgs; [
      # Nix
      nixd
      nixfmt-rfc-style

      # Go
      gopls
      golangci-lint

      # Rust
      rustc
      cargo

      # Web
      nodejs_20
      deno
    ];
  };
}
