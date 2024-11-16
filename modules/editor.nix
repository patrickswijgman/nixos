{ config, pkgs, ... }:

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
        vim-commentary
        fleet-theme-nvim
      ];

      extraLuaConfig = builtins.readFile ../files/nvim/init.lua;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
