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
    # NixOS Official Package Store (Unstable branch)
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    # Home Manager (Manages user dotfiles)
    home-manager.url = "github:nix-community/home-manager";
    # Tell Home Manager to use the exact same system packages as NixOS
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
  let
    # The architecture of your machine
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

  in {
    # -------------------------------------------------------------------------
    # USER CONFIGURATIONS (Home Manager)
    # -------------------------------------------------------------------------
    homeConfigurations = {
      tigerwarrior345 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Where your user config files live
        modules = [
          ./users/tigerwarrior345/home.nix
          # If you want nvim.nix separate, keep it here. 
          # (Otherwise, it's cleaner to import it inside home.nix!)
          ./users/tigerwarrior345/nvim.nix 
        ];
      };
    };

    # -------------------------------------------------------------------------
    # SYSTEM CONFIGURATIONS (NixOS)
    # -------------------------------------------------------------------------
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;

        # Pass inputs to modules so we can use them there if needed
        specialArgs = { inherit inputs; };

        modules = [
          ./system/configuration.nix
        ];
      };
    };
  };
}
