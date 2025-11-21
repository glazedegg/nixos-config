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

  xdg.configFile."hypr/hyprpaper.conf".source = ./hypr/hyprpaper.conf;

  xdg.configFile."waybar/config".source = ./waybar/config.jsonc;
  xdg.configFile."waybar/style.css".source = ./waybar/style.css;

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
      hypr = "nvim ~/.dotfiles/users/tigerwarrior345/hypr/hyprland.conf";
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
    # --- HYPRLAND CORE ---
    waybar                  # The Status Bar
    rofi	            # App Launcher (The menu)
    mako                    # Notification bubbles
    libnotify               # Required for notifications to work
    hyprpaper               # Wallpaper handling
    networkmanagerapplet    # Wifi GUI in the bar

    # --- ESSENTIAL UTILITIES ---
    ghostty                 # Terminal
    kdePackages.dolphin     # File Manager
    kdePackages.ark
    kdePackages.kio-extras
    pavucontrol             # Volume Control GUI (Vital)
    
    # --- WORKFLOW ---
    grim                    # Screenshot tool
    slurp                   # Select area for screenshot
    wl-clipboard            # Copy/Paste functionality
    cliphist
    
    # --- BASIC CLI TOOLS ---
    git
    unzip                   # Open .zip files
    wget                    # Download files
    fastfetch               # System info (You wanted this)
    btop
    zip
    p7zip
    ripgrep
    fd
    bat
    fzf

    # --- HARDWARE CONTROLS ---
    brightnessctl
    playerctl
    blueman

    # --- FONTS ---
    # Required for icons in the bar/launcher to show up
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
