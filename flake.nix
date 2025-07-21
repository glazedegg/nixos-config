{
  description = "System Config";

  inputs = {
    nixpkgs.url        = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url   = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
  in {
    homeManagerConfigurations = {
      tigerwarrior345 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./users/tigerwarrior345/home.nix
          ./users/tigerwarrior345/nvim.nix

          # Inline module to set username, homedir 
	  {
            home.username      = "tigerwarrior345";
            home.homeDirectory = "/home/tigerwarrior345";
          }
        ];
      };
    };

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./system/configuration.nix
        ];
      };
    };
  };
}

