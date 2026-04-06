#!/bin/bash

# Define the target root directory
BASE_DIR="/home/pixel/Programming/School/info-4730"

echo "Creating directory structure in $BASE_DIR..."

# Create the directory tree
mkdir -p "$BASE_DIR/Hyprland-Setup/Core-Wayland/conf.d"
mkdir -p "$BASE_DIR/Hyprland-Setup/Status-Bar/themes/gel"
mkdir -p "$BASE_DIR/Hyprland-Setup/Deployment"

echo "Generating files..."

# ==========================================
# README.md
# ==========================================
cat <<'EOF' >"$BASE_DIR/README.md"
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
EOF

# ==========================================
# Core Wayland Files
# ==========================================
cat <<'EOF' >"$BASE_DIR/Hyprland-Setup/Core-Wayland/hyprland.conf"
# ==========================================
# HYPRLAND MASTER CONFIGURATION
# ==========================================

# 1. Variables and Environment (Must be first)
source = ~/.config/hypr/conf.d/programs.conf
source = ~/.config/hypr/conf.d/env.conf

# 2. Hardware and Startup
source = ~/.config/hypr/conf.d/monitors.conf
source = ~/.config/hypr/conf.d/autostart.conf

# 3. Rules and Keybindings
source = ~/.config/hypr/conf.d/binds.conf
source = ~/.config/hypr/conf.d/rules.conf

###################
### PERMISSIONS ###
###################
ecosystem {
    enforce_permissions = true
    no_update_news = true
}
permission = /usr/bin/grim, screencopy, allow

#####################
### LOOK AND FEEL ###
#####################
general {
    gaps_in = 5
    gaps_out = 20
    border_size = 2
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)
    resize_on_border = false
    allow_tearing = false
    layout = dwindle
}

decoration {
    rounding = 10
    rounding_power = 2
    active_opacity = 1.0
    inactive_opacity = 1.0

    shadow {
        enabled = true
        range = 4
        render_power = 3
        color = rgba(1a1a1aee)
    }

    blur {
        enabled = true
        size = 3
        passes = 1
        vibrancy = 0.1696
    }
}

animations {
    enabled = yes, please :)
    bezier = easeOutQuint,0.23,1,0.32,1
    bezier = easeInOutCubic,0.65,0.05,0.36,1
    bezier = linear,0,0,1,1
    bezier = almostLinear,0.5,0.5,0.75,1.0
    bezier = quick,0.15,0,0.1,1

    animation = global, 1, 10, default
    animation = border, 1, 5.39, easeOutQuint
    animation = windows, 1, 4.79, easeOutQuint
    animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
    animation = windowsOut, 1, 1.49, linear, popin 87%
    animation = fadeIn, 1, 1.73, almostLinear
    animation = fadeOut, 1, 1.46, almostLinear
    animation = fade, 1, 3.03, quick
    animation = layers, 1, 3.81, easeOutQuint
    animation = layersIn, 1, 4, easeOutQuint, fade
    animation = layersOut, 1, 1.5, linear, fade
    animation = fadeLayersIn, 1, 1.79, almostLinear
    animation = fadeLayersOut, 1, 1.39, almostLinear
    animation = workspaces, 1, 1.94, almostLinear, fade
    animation = workspacesIn, 1, 1.21, almostLinear, fade
    animation = workspacesOut, 1, 1.94, almostLinear, fade
}

dwindle {
    pseudotile = true
    preserve_split = true
}

master {
    new_status = master
}

misc {
    force_default_wallpaper = 0
    disable_hyprland_logo = false
}

xwayland {
    enabled = true
    force_zero_scaling = true
}
EOF

cat <<'EOF' >"$BASE_DIR/Hyprland-Setup/Core-Wayland/conf.d/autostart.conf"
# Add all startup processes here
exec-once = systemctl --user start hyprpolkitagent
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
# FIXED PATH: Assuming you move hyprlandPortals.sh to the scripts folder
exec-once = ~/.config/hypr/scripts/hyprlandPortals.sh
exec-once = gnome-keyring-daemon --start --components=pkcs11,secrets,ssh &
exec-once = udiskie &
exec-once = nm-applet &
exec-once = waybar &
exec-once = hyprpaper &
exec-once = dunst &
exec-once = [workspace 1 silent] brave
exec-once = [workspace 2 silent] ghostty
EOF

cat <<'EOF' >"$BASE_DIR/Hyprland-Setup/Core-Wayland/conf.d/binds.conf"
###################
### KEYBINDINGS ###
###################

# Core Application Binds
bind = $mainMod, T, exec, $terminal
bind = $mainMod, B, exec, brave
bind = $mainMod, Space, exec, $menu

# Window Management
bind = $mainMod, C, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, V, togglefloating,
bind = $mainMod, P, pseudo,
bind = $mainMod, J, layoutmsg, togglesplit

# System Operations
bind = $mainMod, W, exec, $waybarReload
bind = $mainMod CTRL SHIFT, escape, exec, systemctl suspend
bind = $mainMod, PRINT, exec, hyprshot -m output --clipboard-only
bind = $mainMod CTRL, PRINT, exec, hyprshot -m window --clipboard-only
bind = $mainMod SHIFT, PRINT, exec, hyprshot -m region --clipboard-only

# Move Focus
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch Workspaces
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move Active Window to Workspace
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Mouse Bindings
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Audio and Brightness Hardware Keys
bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
bindel = ,XF86MonBrightnessUp, exec, brightnessctl set +5%
bindel = ,XF86MonBrightnessDown, exec, brightnessctl set 5%-

# Media Control Keys
bindl = ,XF86AudioNext, exec, playerctl next
bindl = ,XF86AudioPause, exec, playerctl play-pause
bindl = ,XF86AudioPlay, exec, playerctl play-pause
bindl = ,XF86AudioPrev, exec, playerctl previous
EOF

cat <<'EOF' >"$BASE_DIR/Hyprland-Setup/Core-Wayland/conf.d/env.conf"
#############################
### ENVIRONMENT VARIABLES ###
#############################
env = XCURSOR_SIZE,24
env = HYPRCURSOR_SIZE,24
env = QT_QPA_PLATFORMTHEME,qt6ct
env = XDG_SESSION_TYPE,wayland
env = XDG_SESSION_DESKTOP,Hyprland
env = LIBVA_DRIVER_NAME,radeonsi
env = AMD_VULKAN_ICD,radv

#############
### INPUT ###
#############
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =
    follow_mouse = 0
    sensitivity = 0

    touchpad {
        natural_scroll = true
    }
}

device {
    name = epic-mouse-v1
    sensitivity = -0.5
}
EOF

cat <<'EOF' >"$BASE_DIR/Hyprland-Setup/Core-Wayland/conf.d/monitors.conf"
################
### MONITORS ###
################

# See https://wiki.hyprland.org/Configuring/Monitors/
monitor=,preferred,auto,auto
EOF

cat <<'EOF' >"$BASE_DIR/Hyprland-Setup/Core-Wayland/conf.d/programs.conf"
###################
### VARIABLES   ###
###################

$mainMod = SUPER
$terminal = ghostty
$menu = rofi -show drun
$waybarReload = killall -SIGUSR2 waybar
EOF

cat <<'EOF' >"$BASE_DIR/Hyprland-Setup/Core-Wayland/conf.d/rules.conf"
##############################
### WINDOWS AND WORKSPACES ###
##############################

# Boot Programs
windowrule = workspace 5, match:class ^(discord)$

# General Rules
windowrule = suppress_event maximize, match:class .*

# XWayland Dragging Fix
windowrule = no_focus on, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0

# JetBrains IDE Fixes
windowrule = tag +jb, match:class ^jetbrains-.+$, match:float 1
windowrule = stay_focused on, no_initial_focus on, match:tag jb
windowrule = tag +jb, match:class ^jetbrains-.+$, match:float 1, match:title ^(?!win\d+$).*
windowrule = no_focus on, no_initial_focus on, match:class ^jetbrains-.+$, match:title ^win\d+$
EOF

# ==========================================
# Status Bar (Waybar) Files
# ==========================================
cat <<'EOF' >"$BASE_DIR/Hyprland-Setup/Status-Bar/config.jsonc"
// -*- mode: jsonc -*-
{
  "layer": "top",
  "position": "top",
  "height": 30,
  "spacing": 4,
  "reload_style_on_change": true,
  "modules-left": [
    "hyprland/workspaces",
    "hyprland/scratchpad"
  ],
  "modules-center": [
    "hyprland/window"
  ],
  "modules-right": [
    "mpd",
    "pulseaudio",
    "temperature",
    "backlight",
    "keyboard-state",
    "battery",
    "clock",
    "network",
    "tray",
    "custom/power" 
  ],
  "hyprland/workspaces": { 
    "disable-scroll": true,
    "all-outputs": true,
    "warp-on-scroll": false,
    "format": "{name}", 
    "persistent_workspaces": {
      "1": [], "2": [], "3": [], "4": [], "5": [],
      "6": [], "7": [], "8": [], "9": [], "10": []
    }
  },
  "keyboard-state": {
    "numlock": true,
    "capslock": true,
    "format": "{name} {icon}",
    "format-icons": {
      "locked": "",
      "unlocked": ""
    }
  },
  "hyprland/mode": { 
    "format": "<span style=\"italic\">{}</span>"
  },
  "hyprland/scratchpad": { 
    "format": "{icon} {count}",
    "show-empty": false,
    "format-icons": [ "", "" ],
    "tooltip": true,
    "tooltip-format": "{app}: {title}"
  },
  "mpd": {
    "format": "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ",
    "format-disconnected": "Disconnected ",
    "format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ",
    "unknown-tag": "N/A",
    "interval": 5,
    "consume-icons": { "on": " " },
    "random-icons": { "off": "<span color=\"#f53c3c\"></span> ", "on": " " },
    "repeat-icons": { "on": " " },
    "single-icons": { "on": "1 " },
    "state-icons": { "paused": "", "playing": "" },
    "tooltip-format": "MPD (connected)",
    "tooltip-format-disconnected": "MPD (disconnected)"
  },
  "tray": {
    "spacing": 10
  },
  "clock": {
    "format": "{:%I:%M %p}",
    "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
    "format-alt": "{:%Y-%m-%d}"
  },
  "temperature": {
    "critical-threshold": 80,
    "format": "{temperatureC}°C {icon}",
    "format-icons": [ "", "", "" ]
  },
  "backlight": {
    "format": "{percent}% {icon}",
    "format-icons": [ "", "", "", "", "", "", "", "", "" ]
  },
  "battery": {
    "states": {
      "good": 95,
      "warning": 30,
      "critical": 15
    },
    "format": "{capacity}% {icon}",
    "format-full": "{capacity}% {icon}",
    "format-charging": "{capacity}% ",
    "format-plugged": "{capacity}% ",
    "format-alt": "{time} {icon}",
    "format-icons": [ "", "", "", "", "" ]
  },
  "custom/power": {
    "format": "⏻ ",
    "tooltip": true,
    "menu": "on-click",
    "menu-file": "~/.config/waybar/power_menu.xml",
    "menu-actions": {
      "shutdown": "shutdown now",
      "reboot": "reboot",
      "suspend": "systemctl suspend",
      "hibernate": "systemctl hibernate"
    }
  },
  "network": {
    "format-wifi": "{essid} ({signalStrength}%) ",
    "format-ethernet": "{ipaddr}/{cidr} ",
    "tooltip-format": "{ifname} via {gwaddr} ",
    "format-linked": "{ifname} (No IP) ",
    "format-disconnected": "Disconnected ⚠",
    "format-alt": "{ifname}: {ipaddr}/{cidr}"
  },
  "pulseaudio": {
    "format": "{volume}% {icon} | {format_source}",
    "format-bluetooth": "{volume}% {icon} {format_source}",
    "format-bluetooth-muted": "{icon} {format_source}",
    "format-muted": "󰝟 | {format_source}",
    "format-source": "{volume}% ",
    "format-source-muted": "",
    "format-icons": {
      "headphone": "",
      "hands-free": "",
      "headset": "",
      "phone": "",
      "portable": "",
      "car": "",
      "default": [ "", "", "" ]
    },
    "on-click": "pavucontrol" 
  }
}
EOF

cat <<'EOF' >"$BASE_DIR/Hyprland-Setup/Status-Bar/style.css"
@import "themes/gel/style.css";
EOF

cat <<'EOF' >"$BASE_DIR/Hyprland-Setup/Status-Bar/power_menu.xml"
<?xml version="1.0" encoding="UTF-8"?>
<interface>
  <object class="GtkMenu" id="menu">
        <child>
            <object class="GtkMenuItem" id="suspend">
                <property name="label">Suspend</property>
            </object>
        </child>
        <child>
            <object class="GtkMenuItem" id="hibernate">
                <property name="label">Hibernate</property>
            </object>
        </child>
    <child>
            <object class="GtkMenuItem" id="shutdown">
                <property name="label">Shutdown</property>
            </object>
    </child>
    <child>
      <object class="GtkSeparatorMenuItem" id="delimiter1"/>
    </child>
    <child>
            <object class="GtkMenuItem" id="reboot">
                <property name="label">Reboot</property>
            </object>
    </child>
  </object>
</interface>
EOF

cat <<'EOF' >"$BASE_DIR/Hyprland-Setup/Status-Bar/themes/gel/style.css"
* {
  font-family: "0xProto Nerd Font", "JetbrainsMono Nerd Font", "FontAwesome",
    "Roboto", "Helvetica", "Arial", "sans-serif", "Noto Color Emoji", "monospace";
  font-size: 13px;
}

/* --- BAR SURFACE (glass) --- */
window#waybar {
  background: rgba(20, 22, 28, 0.35);
  color: rgba(255, 255, 255, 0.92);

  border: 1px solid rgba(255, 255, 255, 0.14);
  border-radius: 14px;

  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.18),
    inset 0 -1px 0 rgba(0, 0, 0, 0.25),
    0 10px 26px rgba(0, 0, 0, 0.35);

  margin: 6px 10px;
  padding: 2px 6px;

  transition-property: background-color;
  transition-duration: .25s;
}

window#waybar.hidden {
  opacity: 0.2;
}

#window,
#workspaces {
  margin: 0 4px;
}

.modules-left > widget:first-child > #workspaces { margin-left: 0; }
.modules-right > widget:last-child > #workspaces { margin-right: 0; }

/* --- DEFAULT MODULE "PILL" (gel) --- */
#clock,
#battery,
#temperature,
#backlight,
#network,
#pulseaudio,
#tray,
#scratchpad,
#power-profiles-daemon,
#mpd,
#keyboard-state {
  padding: 0 10px;
  margin: 4px 3px;

  border-radius: 12px;
  border: 1px solid rgba(255, 255, 255, 0.14);

  background: rgba(255, 255, 255, 0.08);

  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.28),
    inset 0 8px 18 rgba(255, 255, 255, 0.06),
    inset 0 -2px 8 rgba(0, 0, 0, 0.28);
}

#keyboard-state {
  padding: 0 6px;
}

button {
  border: none;
  border-radius: 0;
  box-shadow: none;
}
button:hover {
  background: rgba(255, 255, 255, 0.07);
}

/* --- WORKSPACES: gel stickers --- */
#workspaces button {
  padding: 0 8px;
  margin: 4px 3px;

  border-radius: 12px;
  border: 1px solid rgba(255, 255, 255, 0.10);

  background: rgba(255, 255, 255, 0.06);
  color: rgba(255, 255, 255, 0.92);

  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.16),
    inset 0 -2px 6px rgba(0, 0, 0, 0.22);
}

#workspaces button:hover {
  background: rgba(255, 255, 255, 0.10);
}

#workspaces button.active {
  background: rgba(120, 180, 255, 0.22);
  border: 1px solid rgba(160, 210, 255, 0.20);

  box-shadow:
    inset 0 1px 0 rgba(255, 255, 255, 0.22),
    inset 0 -2px 8px rgba(0, 0, 0, 0.28);
}

#workspaces button.urgent {
  background: rgba(235, 77, 75, 0.25);
  border: 1px solid rgba(255, 180, 180, 0.18);
}

/* --- MODULE ACCENTS --- */
@keyframes blink {
  to {
    background-color: rgba(255, 255, 255, 0.18);
    color: rgba(0, 0, 0, 0.85);
  }
}
#battery.critical:not(.charging) {
  background: rgba(245, 60, 60, 0.24);
  animation-name: blink;
  animation-duration: 0.5s;
  animation-timing-function: steps(12);
  animation-iteration-count: infinite;
  animation-direction: alternate;
}

#keyboard-state > label + label {
  margin-left: 8px;
}

#clock { background: rgba(255, 0, 0, 0.20); }
#battery { background: rgba(255, 255, 255, 0.16); }
#battery.charging, #battery.plugged { background: rgba(46, 204, 113, 0.22); }
#battery.critical:not(.charging) { background: rgba(245, 60, 60, 0.26); }
#backlight { background: rgba(255, 220, 140, 0.18); }
#keyboard-state { background: rgba(1, 225, 3, 0.18); }
#tray { background: rgba(41, 128, 185, 0.16); }
#mpd { background: rgba(102, 204, 153, 0.18); }
#mpd.disconnected { background: rgba(245, 60, 60, 0.22); }
#mpd.stopped { background: rgba(144, 177, 177, 0.18); }
#mpd.paused { background: rgba(81, 163, 122, 0.20); }
#network { background: rgba(41, 128, 185, 0.20); }
#network.disconnected { background: rgba(245, 60, 60, 0.24); }
#pulseaudio { background: rgba(241, 196, 15, 0.22); }
#pulseaudio.muted { background: rgba(255, 0, 0, 0.48); }
EOF

# ==========================================
# Deployment Script
# ==========================================
cat <<'EOF' >"$BASE_DIR/Hyprland-Setup/Deployment/install.sh"
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
EOF

# Make the installation script executable
chmod +x "$BASE_DIR/Hyprland-Setup/Deployment/install.sh"

echo "Repository generation complete! You can now run 'cd $BASE_DIR', initialize git ('git init'), and push to GitHub."
