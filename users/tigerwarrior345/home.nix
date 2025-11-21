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
  # USER INFORMATION
  # ---------------------------------------------------------------------------
  home.username = "tigerwarrior345";
  home.homeDirectory = "/home/tigerwarrior345";

  # ---------------------------------------------------------------------------
  # HYPRLAND CONFIGURATION (The Connection)
  # ---------------------------------------------------------------------------
  # Instead of using absolute paths (which break if you move the folder),
  # we use the Nix standard "xdg.configFile".
  # This tells Home Manager: "Take the file 'hyprland.conf' from this folder,
  # and link it to ~/.config/hypr/hyprland.conf"
  
  xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;

  # If you have a separate waybar config in this folder, uncomment this:
  # xdg.configFile."waybar/config".source = ./waybar-config;
  # xdg.configFile."waybar/style.css".source = ./waybar-style.css;

  # ---------------------------------------------------------------------------
  # SHELL ALIASES (Shortcuts)
  # ---------------------------------------------------------------------------
  programs.bash = {
    enable = true;
    shellAliases = {
      # "Update System" - Requires password
      sysup = "cd ~/.dotfiles && sudo nixos-rebuild switch --flake .";

      # "Update User/Home" - No password
      homeup = "cd ~/.dotfiles && home-manager switch --flake .";
      
      # Quick edit shortcuts
      conf = "nvim ~/.dotfiles/system/configuration.nix";
      home = "nvim ~/.dotfiles/users/tigerwarrior345/home.nix";
    };
  };

  # ---------------------------------------------------------------------------
  # GPG & SECURITY
  # ---------------------------------------------------------------------------
  programs.gpg.enable = true;
  
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt;
  };

  # ---------------------------------------------------------------------------
  # PACKAGES (The "Furniture")
  # ---------------------------------------------------------------------------
  home.packages = with pkgs; [
    # --- TERMINAL & TOOLS ---
    ghostty
    fastfetch
    git
    git-crypt
    gnupg
    pinentry-qt
    ripgrep    # Much faster version of grep
    btop       # Cool looking task manager

    # --- HYPRLAND ECOSYSTEM ---
    waybar                  # Status bar
    mako                    # Notification daemon
    libnotify               # Required for mako to work
    networkmanagerapplet    # Wifi GUI in tray
    hyprpaper               # Wallpaper daemon
    blueman                 # Bluetooth GUI
    rofi	            # App launcher (Wayland version)
    wl-clipboard            # Copy/Paste support
    
    # --- KDE / GUI APPS ---
    kdePackages.sddm-kcm        # Settings for Login screen
    kdePackages.kcalc           # Calculator
    kdePackages.partitionmanager # Disk Manager
    kdePackages.dolphin         # File Manager (Optional, good to have)
    
    # --- FONTS (Optional) ---
    # If icons in Waybar look weird, you usually need a Nerd Font
    nerd-fonts.jetbrains-mono
  ];

  # ---------------------------------------------------------------------------
  # ENVIRONMENT VARIABLES
  # ---------------------------------------------------------------------------
  home.sessionVariables = {
    EDITOR = "nvim";
    # Tell Electron apps to use Wayland
    NIXOS_OZONE_WL = "1"; 
  };

  # ---------------------------------------------------------------------------
  # HOME MANAGER SETUP
  # ---------------------------------------------------------------------------
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # DO NOT CHANGE THIS. It matches the version of Home Manager you first installed.
  home.stateVersion = "25.05"; 
}
