# =============================================================================
#  FLAKE CONFIGURATION (The "Architect")
# =============================================================================
#
#  WHO IS THIS FILE FOR?
#  This is the entry point. It tells Nix where to get software (Inputs)
#  and how to build your specific machine (Outputs).
#
#  WHEN TO EDIT THIS?
#  - You want to update the system version (e.g. nixos-unstable).
#  - You want to add a new machine or user.
#
#  HOW TO APPLY CHANGES?
#  $ nix flake update
#  $ sudo nixos-rebuild switch --flake .
# =============================================================================

{
  description = "System Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
  in {
    # -------------------------------------------------------------------------
    # USER CONFIGURATIONS
    # -------------------------------------------------------------------------
    homeConfigurations = {
      # Name this "username@hostname".
      # When you run 'homeup' on your laptop, it looks for exactly this string.
      "tigerwarrior345@laptop" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/tigerwarrior345/home.nix
          ./users/tigerwarrior345/nvim.nix 
        ];
      };
      
      # If you get a desktop later, you just add:
      # "tigerwarrior345@desktop" = ...
    };

    # -------------------------------------------------------------------------
    # SYSTEM CONFIGURATIONS
    # -------------------------------------------------------------------------
    nixosConfigurations = {
      # Name this "laptop".
      # When you run 'sysup', it checks your hostname ('laptop') and picks this.
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/laptop/configuration.nix
        ];
      };
      # If you get a desktop later, you just add:
      # desktop = ...
    };
  };
}
