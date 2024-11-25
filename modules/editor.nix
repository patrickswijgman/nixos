{ config, pkgs, ... }:

let
  fleet-theme-nvim = pkgs.callPackage ./custom/fleet-theme-nvim.nix { };
in
{
  home-manager.users.patrick = {
    programs.neovim = {
      enable = true;

      # https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=vimPlugins
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
        copilot-vim
        auto-session
        nvim-colorizer-lua
        zen-mode-nvim
        (fleet-theme-nvim)
      ];
    };

    home.file.".config/nvim" = {
      source = ../files/nvim;
      recursive = true;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
