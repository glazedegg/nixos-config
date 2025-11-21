{ pkgs, ... }:
{
  # Enable Hyprland
  programs.hyprland.enable = true;

  # Display Manager (SDDM)
  services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
  };
  services.displayManager.defaultSession = "hyprland";
}
