{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
        copilot-vim
        conform-nvim
        auto-session
        catppuccin-nvim
      ];
    };

    home.file.".config/nvim" = {
      source = ../../files/nvim;
      recursive = true;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
