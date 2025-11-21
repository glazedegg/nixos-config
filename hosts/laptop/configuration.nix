# =============================================================================
#  NixOS SYSTEM CONFIGURATION (The "Landlord")
# =============================================================================
#
#  WHO IS THIS FILE FOR?
#  This file controls the "Physical House." It manages hardware, drivers, 
#  booting, root users, and system-wide services (like Audio/Wifi).
#
#  WHEN TO EDIT THIS?
#  - You need to fix Audio, Wifi, or Graphics drivers.
#  - You want to add a new user account.
#  - You want to install "Infrastructure" software (Docker, VPNs, Steam).
#
#  HOW TO APPLY CHANGES?
#  Since this modifies the OS, you need admin rights:
#  $ sudo nixos-rebuild switch --flake .
# =============================================================================

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/system/hyprland.nix
      ../../modules/system/sound.nix
    ];

  # ---------------------------------------------------------------------------
  # BOOTLOADER & KERNEL
  # Critical for starting the computer.
  # ---------------------------------------------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Use the latest Linux kernel (good for newer hardware/gaming)
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ---------------------------------------------------------------------------
  # NETWORKING
  # ---------------------------------------------------------------------------
  networking.hostName = "laptop"; 
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant
  
  # Enable NetworkManager (easiest way to manage Wifi/Ethernet)
  # Use 'nmtui' in the terminal to connect to Wifi.
  networking.networkmanager.enable = true;

  # ---------------------------------------------------------------------------
  # TIME & LOCALE
  # Controls your clock and how dates/currency appear.
  # ---------------------------------------------------------------------------
  time.timeZone = "Europe/Stockholm";
  
  # System default language
  i18n.defaultLocale = "en_US.UTF-8";

  # Regional settings (Swedish formats for dates/numbers)
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # ---------------------------------------------------------------------------
  # KEYMAP (KEYBOARD LAYOUT)
  # ---------------------------------------------------------------------------
  # For the graphical environment (X11/Wayland)
  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };
  
  # For the TTY (black screen terminal before login)
  console.keyMap = "sv-latin1";

  # ---------------------------------------------------------------------------
  # DESKTOP ENVIRONMENT & LOGIN SCREEN
  # ---------------------------------------------------------------------------
  # PLASMA 6 (KDE): A backup desktop environment.
  # Useful if you break your Hyprland config and need a GUI to fix it.
  services.desktopManager.plasma6.enable = true;
  
  # ---------------------------------------------------------------------------
  # PRINTERS
  # ---------------------------------------------------------------------------
  services.printing.enable = true;

  # ---------------------------------------------------------------------------
  # USER ACCOUNTS
  # ---------------------------------------------------------------------------
  users.users.tigerwarrior345 = {
    isNormalUser = true;
    description = "tigerwarrior345";
    # 'wheel' enables sudo privileges, 'networkmanager' allows changing wifi
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # You can add packages here, but it's better to use Home Manager
      # for user-specific apps (like browsers, discord, etc.)
    ];
  };

  # ---------------------------------------------------------------------------
  # SYSTEM-WIDE PACKAGES
  # ---------------------------------------------------------------------------
  # Apps installed here are available to ALL users.
  # Best for CLI tools (git, vim, wget) that you need for system maintenance.
  environment.systemPackages = with pkgs; [
    gimp
    git 
    vim 
    wget
  ];

  # Firefox is a "Program" module, often better configured this way than in packages
  programs.firefox.enable = true;
  
  # Allow proprietary software (Spotify, Steam, Nvidia drivers, etc.)
  nixpkgs.config.allowUnfree = true;
  
  # Enable Flakes (The modern Nix command system)
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # ---------------------------------------------------------------------------
  # SYSTEM STATE VERSION
  # ---------------------------------------------------------------------------
  # DO NOT CHANGE THIS unless you reinstall NixOS from scratch.
  # It does not limit your updates; it ensures database compatibility.
  system.stateVersion = "25.05";
}
