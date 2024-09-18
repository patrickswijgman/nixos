{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    functions = {
      fish_prompt.body = builtins.readFile ../../files/fish/functions/fish_prompt.fish;
    };
  };

  programs.keychain = {
    enable = true;
    enableFishIntegration = true;
    keys = [
      "~/.ssh/id_ed25519"
    ];
  };
}
