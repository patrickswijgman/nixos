{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    programs.fish = {
      enable = true;
      interactiveShellInit = builtins.readFile ../files/fish/init.fish;
      functions = {
        fish_prompt.body = builtins.readFile ../files/fish/functions/fish_prompt.fish;
        fzg.body = builtins.readFile ../files/fish/functions/fzg.fish;
      };
      shellAbbrs = {
        lg = "lazygit";
      };
    };

    programs.keychain = {
      enable = true;
      enableFishIntegration = true;
      keys = [
        "~/.ssh/id_ed25519"
      ];
    };
  };
}
