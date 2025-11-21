# NixOS Configuration
Modular NixOS configuration using Flakes and Home Manager.

## Structure

*   **`flake.nix`**: Entry point. Maps hosts (e.g., "laptop") and users to configurations.
*   **`hosts/`**: Hardware-specific settings (bootloader, kernel modules, drivers).
    *   `configuration.nix`: Host-specific settings.
    *   `hardware-configuration.nix`: Auto-generated hardware scan.
*   **`modules/`**: Shared configuration blocks.
    *   `system/`: OS-level features (Hyprland enable, audio, system packages).
    *   `user/`: Home Manager software groups (desktop.nix, shell.nix).
*   **`users/`**: User data and dotfiles.
    *   `home.nix`: Links modules and dotfiles.
    *   `hypr/`, `waybar/`, etc: Config files linked to `~/.config/`.

## Aliases

Defined in `modules/user/shell.nix`.

| Alias | Command | Action |
| :--- | :--- | :--- |
| `sysup` | `sudo nixos-rebuild switch --flake .` | Rebuild System (requires sudo) |
| `homeup` | `home-manager switch --flake .` | Rebuild User |
| `conf` | `nvim .../configuration.nix` | Edit Host config |
| `home` | `nvim .../home.nix` | Edit Home config |
| `hypr` | `nvim .../hyprland.conf` | Edit Hyprland config |

## Usage

### Installing Software
*   **CLI / Terminal**: Edit `modules/user/shell.nix`. Run `homeup`.
*   **GUI / Fonts**: Edit `modules/user/desktop.nix`. Run `homeup`.
*   **System / Drivers**: Edit `hosts/<hostname>/configuration.nix`. Run `sysup`.

### Updating
1.  `nix flake update`
2.  `sysup`
3.  `homeup`

## Adding a New Machine

1.  **Hardware Config**:
    ```bash
    mkdir hosts/desktop
    cp /etc/nixos/hardware-configuration.nix hosts/desktop/
    ```
2.  **Host Config**:
    Copy `hosts/laptop/configuration.nix` to `hosts/desktop/`. Update `networking.hostName`.
3.  **Flake**:
    Add `desktop` to `nixosConfigurations` and `<user>@desktop` to `homeConfigurations`.
4.  **Bootstrap**:
    ```bash
    git add .
    sudo nixos-rebuild switch --flake .#desktop
    home-manager switch --flake .#<user>@desktop
    ```

## Notes

*   **Git Tracking**: Nix Flakes ignores files not added to git. If a file "does not exist," run `git add .`.
*   **Dotfiles**: Configs in `users/` are symlinked. Edits usually take effect immediately on file save.
