{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    functions = {
      fish_prompt.body = builtins.readFile ./fish_prompt.fish;
    };
  };
}
