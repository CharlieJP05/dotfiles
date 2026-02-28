#!/bin/bash
# Apply unitheme to Hyprlauncher

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/theme.conf"

LAUNCHER_CONF="${HOME}/.config/hypr/hyprlauncher.conf"

if [[ ! -f "$LAUNCHER_CONF" ]]; then
    echo "Hyprlauncher config not found: $LAUNCHER_CONF"
    exit 1
fi

# Convert #RRGGBB to Hyprlauncher 0xFFRRGGBB format (uppercase)
hex_to_launcher() {
    local hex="${1#'#'}"
    echo "0xFF${hex^^}"
}

BG=$(hex_to_launcher "$HYPRLAUNCHER_BG")
FG=$(hex_to_launcher "$HYPRLAUNCHER_FG")
SEL=$(hex_to_launcher "$HYPRLAUNCHER_SELECTED")
ACC=$(hex_to_launcher "$HYPRLAUNCHER_ACCENT")

sed -i \
    -e "s|background_color = .*|background_color = ${BG}|" \
    -e "s|foreground_color = .*|foreground_color = ${FG}|" \
    -e "s|selected_color = .*|selected_color = ${SEL}|" \
    -e "s|accent_color = .*|accent_color = ${ACC}|" \
    "$LAUNCHER_CONF"

echo "Applied theme to Hyprlauncher"
