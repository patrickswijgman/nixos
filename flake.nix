{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Use vscode-langservers-extracted pinned at 4.8.0 for Helix.
    # https://github.com/hrsh7th/vscode-langservers-extracted/commit/859ca87fd778a862ee2c9f4c03017775208d033a#comments
    oldNixpkgs.url = "github:nixos/nixpkgs?rev=e89cf1c932006531f454de7d652163a9a5c86668";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, ... }@inputs:
    {
      nixosConfigurations = {
        acer = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./configuration.nix
            ./hosts/acer/configuration.nix
          ];
        };

        work = inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./configuration.nix
            ./hosts/work/configuration.nix
          ];
        };
      };
    };
}
