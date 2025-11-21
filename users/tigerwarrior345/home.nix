# =============================================================================
#  HOME MANAGER CONFIGURATION (The "Tenant")
# =============================================================================
#
#  WHO IS THIS FILE FOR?
#  This file configures YOU (the user). It controls your applications, 
#  dotfiles, themes, and shell aliases.
#
#  WHEN TO EDIT THIS?
#  - You want to install user apps (Discord, Spotify, VS Code).
#  - You want to change your specific Hyprland settings (keybinds, colors).
#  - You want to add shell aliases.
#
#  HOW TO APPLY CHANGES?
#  $ home-manager switch --flake .
# =============================================================================

{ config, pkgs, ... }:

{
  # ---------------------------------------------------------------------------
  # IMPORTS
  # ---------------------------------------------------------------------------
  imports = [
    ../../modules/user/shell.nix
    ../../modules/user/desktop.nix
  ];

  # ---------------------------------------------------------------------------
  # USER INFORMATION
  # ---------------------------------------------------------------------------
  home.username = "tigerwarrior345";
  home.homeDirectory = "/home/tigerwarrior345";

  # ---------------------------------------------------------------------------
  # CONFIG LINKS
  # ---------------------------------------------------------------------------
  xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;
  xdg.configFile."hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;
  xdg.configFile."waybar/config".source = ./waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;
  xdg.configFile."rofi/config.rasi".source = ./rofi/config.rasi;

  # ---------------------------------------------------------------------------
  # GPG & SECURITY
  # ---------------------------------------------------------------------------
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
  };

  # ---------------------------------------------------------------------------
  # HOME MANAGER SETUP
  # ---------------------------------------------------------------------------
  programs.home-manager.enable = true;
  home.stateVersion = "25.05"; 
}
