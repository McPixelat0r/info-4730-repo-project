#!/bin/bash

# Stop the script immediately if any command fails
set -e

echo "Starting installation for Hyprland and Waybar dependencies..."

# Step 1: Update the system
echo "Updating system..."
sudo pacman -Syu

# Step 2: Install required packages and fonts
echo "Installing core packages and required fonts..."
sudo pacman -S --needed hyprland rofi-wayland dunst hyprpaper grim network-manager-applet udiskie gnome-keyring brightnessctl playerctl wireplumber ttf-jetbrains-mono-nerd ttf-font-awesome

# Step 3: Create the necessary folders on the user's computer
echo "Creating configuration directories..."
mkdir -p ~/.config/hypr/conf.d
mkdir -p ~/.config/hypr/scripts
mkdir -p ~/.config/waybar/themes/gel

# Step 4: Copy the repository files to the local config directories
echo "Copying configuration files..."
cp -r ../Core-Wayland/* ~/.config/hypr/
cp -r ../Status-Bar/config.jsonc ~/.config/waybar/
cp -r ../Status-Bar/style.css ~/.config/waybar/
cp -r ../Status-Bar/power_menu.xml ~/.config/waybar/
cp -r ../Status-Bar/themes/* ~/.config/waybar/themes/

echo "Installation complete. Make sure to restart your session."
