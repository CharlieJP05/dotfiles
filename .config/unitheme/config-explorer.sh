#!/bin/bash
# Config Explorer — browse and edit configuration files with nano,
# then return here automatically when done.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# List of "Label|path" entries shown in the menu.
# Add new entries here to include more configs in the explorer.
CONFIGS=(
    "Unitheme — Colors & Settings|${SCRIPT_DIR}/theme.conf"
    "Hyprland — Window Manager|${HOME}/.config/hypr/hyprland.conf"
    "Hyprland — Lock Screen|${HOME}/.config/hypr/hyprlock.conf"
    "Hyprland — Idle Daemon|${HOME}/.config/hypr/hypridle.conf"
    "Hyprland — Wallpaper|${HOME}/.config/hypr/hyprpaper.conf"
    "Hyprlauncher — App Launcher|${HOME}/.config/hypr/hyprlauncher.conf"
    "Waybar — Bar Config|${HOME}/.config/waybar/config"
    "Waybar — Style|${HOME}/.config/waybar/style.css"
    "Waybar — Color Palette|${HOME}/.config/waybar/macchiato.css"
    "Kitty — Terminal|${HOME}/.config/kitty/kitty.conf"
    "Btop — System Monitor|${HOME}/.config/btop/btop.conf"
    "Btop — Color Theme|${HOME}/.config/btop/themes/catppuccin_macchiato.theme"
    "Wofi — Style|${HOME}/.config/wofi/style.css"
    "Wofi — Config|${HOME}/.config/wofi/config"
    "Wlogout — Style|${HOME}/.config/wlogout/style.css"
    "Bashrc|${HOME}/.bashrc"
)

print_menu() {
    clear
    echo "┌─────────────────────────────────────────────────────┐"
    echo "│              Config Explorer                        │"
    echo "├─────────────────────────────────────────────────────┤"
    local i
    for i in "${!CONFIGS[@]}"; do
        IFS='|' read -r label path <<< "${CONFIGS[$i]}"
        local num
        printf -v num "%2d" $((i + 1))
        if [[ -f "$path" ]]; then
            printf "│  %s. %-46s│\n" "$num" "$label"
        else
            printf "│  %s. %-38s [missing]│\n" "$num" "$label"
        fi
    done
    echo "├─────────────────────────────────────────────────────┤"
    echo "│   a. Apply theme (set-theme.sh)                     │"
    echo "│   q. Quit                                           │"
    echo "└─────────────────────────────────────────────────────┘"
    echo ""
}

while true; do
    print_menu
    read -rp "Select a config to edit (number), or a/q: " choice

    case "$choice" in
        q|Q)
            clear
            break
            ;;
        a|A)
            echo ""
            bash "$SCRIPT_DIR/set-theme.sh"
            echo ""
            read -rp "Press Enter to continue..."
            ;;
        ''|*[!0-9]*)
            echo "Invalid option. Press Enter to try again."
            read -r
            ;;
        *)
            idx=$((choice - 1))
            if [[ $idx -ge 0 && $idx -lt ${#CONFIGS[@]} ]]; then
                IFS='|' read -r label path <<< "${CONFIGS[$idx]}"
                if [[ -f "$path" ]]; then
                    nano "$path"
                else
                    echo "File not found: $path"
                    read -rp "Press Enter to continue..."
                fi
            else
                echo "Number out of range. Press Enter to try again."
                read -r
            fi
            ;;
    esac
done
