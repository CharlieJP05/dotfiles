#!/bin/bash
# Apply unitheme to Hyprland configuration

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/theme.conf"

HYPR_CONF="${HOME}/.config/hypr/hyprland.conf"

if [[ ! -f "$HYPR_CONF" ]]; then
    echo "Hyprland config not found: $HYPR_CONF"
    exit 1
fi

# Convert #RRGGBB to Hyprland 0xAARRGGBB format
hex_to_hypr() {
    local hex="${1#'#'}"
    local alpha="${2:-ff}"
    echo "0x${alpha}${hex}"
}

BORDER_COL=$(hex_to_hypr "$HYPR_BORDER_COLOR" "$HYPR_BORDER_ALPHA")
SHADOW_COL=$(hex_to_hypr "$HYPR_SHADOW_COLOR" "$HYPR_SHADOW_ALPHA")

sed -i \
    -e "s|col\.active_border = .*|col.active_border = ${BORDER_COL}|" \
    -e "s|color = 0x[0-9a-fA-F]\{8\}|color = ${SHADOW_COL}|" \
    -e "s|active_opacity = [0-9.]*|active_opacity = ${HYPR_ACTIVE_OPACITY}|" \
    -e "s|inactive_opacity = [0-9.]*|inactive_opacity = ${HYPR_INACTIVE_OPACITY}|" \
    -e "s|rounding = [0-9]*|rounding = ${HYPR_ROUNDING}|" \
    -e "s|border_size = [0-9]*|border_size = ${HYPR_BORDER_SIZE}|" \
    "$HYPR_CONF"

echo "Applied theme to Hyprland"

# Reload Hyprland if running
if command -v hyprctl &>/dev/null && hyprctl version &>/dev/null 2>&1; then
    hyprctl reload && echo "Reloaded Hyprland"
fi
