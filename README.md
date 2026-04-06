# Arch Linux Wayland Repository

This repository archives user configuration files (dotfiles), custom shell scripts, and visual customizations for an Arch Linux environment utilizing the Wayland display server protocol, specifically targeting the Hyprland tiling window manager and Waybar status bar.

## Organization
* **Hyprland-Setup/Core-Wayland:** Contains the root configuration and modular split files for system behavior, keybindings, and rules.
* **Hyprland-Setup/Status-Bar:** Contains the Waybar configuration, XML power menus, and modular CSS theming (Gel aesthetic).
* **Hyprland-Setup/Deployment:** Contains the `install.sh` script to automate system dependency resolution and file placement.

## Dublin Core Metadata (5 Indexed Items)

**Item 1: Hyprland Master Configuration**
* **Title:** Hyprland Master Configuration
* **Environment Target:** Arch Linux, Wayland, Hyprland
* **Upload Date:** 2026-04-05
* **File Formats:** .conf
* **Dependency Tree:** Acts as the root. Requires `programs.conf`, `env.conf`, `monitors.conf`, `autostart.conf`, `binds.conf`, and `rules.conf` to function.

**Item 2: Hardware Keybindings and Input Rules**
* **Title:** Hardware Keybindings and Input Rules
* **Environment Target:** Arch Linux, Wayland, Hyprland
* **Upload Date:** 2026-04-05
* **File Formats:** .conf
* **Dependency Tree:** Sourced by `hyprland.conf`. Requires `playerctl`, `brightnessctl`, and `wpctl` packages for hardware media and brightness control bindings to execute.

**Item 3: Startup Execution Sequence**
* **Title:** Startup Execution Sequence
* **Environment Target:** Arch Linux, Wayland, Hyprland
* **Upload Date:** 2026-04-05
* **File Formats:** .conf
* **Dependency Tree:** Sourced by `hyprland.conf`. Requires daemons such as `hyprpolkitagent`, `udiskie`, `nm-applet`, `waybar`, `hyprpaper`, and `dunst` to be installed on the host system.

**Item 4: Waybar Core Configuration**
* **Title:** Status Bar Module Configuration
* **Environment Target:** Arch Linux, Wayland
* **Upload Date:** 2026-04-05
* **File Formats:** .jsonc
* **Dependency Tree:** Requires `waybar` package. Imports `power_menu.xml` for system state controls.

**Item 5: System Dependency Deployment Script**
* **Title:** System Dependency Deployment Script
* **Environment Target:** Arch Linux (pacman package manager)
* **Upload Date:** 2026-04-05
* **File Formats:** .sh
* **Dependency Tree:** Standalone script. Executes `pacman` commands to retrieve dependencies listed in the Wayland configurations and moves files to the `~/.config/hypr/` directory.
