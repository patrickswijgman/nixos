{ config, pkgs, ... }:

{
  home-manager.users.patrick = {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
      shellAliases = {
        lg = "lazygit";
      };
      shellAbbrs = {
        gc = "git checkout";
        gb = "git checkout -b";
        gp = "git pull";
        gP = "git push";
        ga = "git add .";
        gm = "git commit -m";
        gma = "git commit --amend";
        gd = "git diff";
        gl = "git log";
        gs = "git status";
        gr = "git rebase -i";
        gra = "git rebase --abort";
        grc = "git rebase --continue";
        grs = "git restore";
        ns = "nix-shell --run fish -p";
      };
      functions = {
        fish_prompt = builtins.readFile ../files/fish/functions/fish_prompt.fish;
      };
    };

    programs.keychain = {
      enable = true;
      keys = [
        "~/.ssh/id_ed25519"
      ];
      extraFlags = [
        "--quiet"
        "--timeout 3600"
      ];
    };
  };

  # Enable fish on system level as well to disable the shell warning.
  programs.fish.enable = true;

  # Set default shell.
  users.users.patrick = {
    shell = pkgs.fish;
  };
}
