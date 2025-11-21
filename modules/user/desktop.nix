{ pkgs, ... }:

{
  # --- GUI & HYPRLAND PACKAGES ---
  home.packages = with pkgs; [
    # Desktop Core
    waybar
    rofi
    mako
    libnotify
    hyprpaper
    wlogout
    networkmanagerapplet
    
    # Tools
    grim
    slurp
    wl-clipboard
    cliphist
    brightnessctl
    playerctl
    blueman
    
    # Apps
    kdePackages.dolphin
    kdePackages.ark
    kdePackages.kio-extras
    pavucontrol
    
    # Fonts
    nerd-fonts.jetbrains-mono
  ];
  
  # Tell Electron apps to use Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
