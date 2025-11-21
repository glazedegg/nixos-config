{ pkgs, ... }:

{
  # --- SHELL CONFIGURATION ---
  programs.bash = {
    enable = true;
    shellAliases = {
      sysup = "cd ~/.dotfiles && sudo nixos-rebuild switch --flake .";
      homeup = "cd ~/.dotfiles && home-manager switch --flake .";
      conf = "nvim ~/.dotfiles/hosts/laptop/configuration.nix";
      home = "nvim ~/.dotfiles/users/tigerwarrior345/home.nix";
      hypr = "nvim ~/.dotfiles/users/tigerwarrior345/hypr/hyprland.conf";
    };
  };

  # --- ENVIRONMENT VARIABLES ---
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # --- CLI PACKAGES ---
  home.packages = with pkgs; [
    # Core
    git
    fastfetch
    btop
    ripgrep
    fd
    bat
    fzf
    
    # Archives
    unzip
    zip
    p7zip
    
    # Networking
    wget
    
    # Editors
    ghostty
    # neovim (if you want to add it here later)
  ];
}
