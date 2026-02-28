#!/bin/bash
# Apply unitheme colors to Kitty terminal emulator

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/theme.conf"

KITTY_CONF="${HOME}/.config/kitty/kitty.conf"

if [[ ! -f "$KITTY_CONF" ]]; then
    echo "Kitty config not found: $KITTY_CONF"
    exit 1
fi

sed -i \
    -e "s|^foreground[[:space:]].*|foreground              ${COLOR_TEXT}|" \
    -e "s|^background[[:space:]].*|background              ${COLOR_BASE}|" \
    -e "s|^selection_foreground[[:space:]].*|selection_foreground    ${COLOR_BASE}|" \
    -e "s|^selection_background[[:space:]].*|selection_background    ${COLOR_ROSEWATER}|" \
    -e "s|^cursor[[:space:]].*|cursor                  ${COLOR_ROSEWATER}|" \
    -e "s|^url_color[[:space:]].*|url_color               ${COLOR_ROSEWATER}|" \
    -e "s|^color0[[:space:]].*|color0 ${COLOR_SURFACE1}|" \
    -e "s|^color8[[:space:]].*|color8 ${COLOR_SURFACE2}|" \
    -e "s|^color1[[:space:]].*|color1 ${COLOR_RED}|" \
    -e "s|^color9[[:space:]].*|color9 ${COLOR_RED}|" \
    -e "s|^color2[[:space:]].*|color2  ${COLOR_GREEN}|" \
    -e "s|^color10[[:space:]].*|color10 ${COLOR_GREEN}|" \
    -e "s|^color3[[:space:]].*|color3  ${COLOR_YELLOW}|" \
    -e "s|^color11[[:space:]].*|color11 ${COLOR_YELLOW}|" \
    -e "s|^color4[[:space:]].*|color4  ${COLOR_BLUE}|" \
    -e "s|^color12[[:space:]].*|color12 ${COLOR_BLUE}|" \
    -e "s|^color5[[:space:]].*|color5  ${COLOR_PINK}|" \
    -e "s|^color13[[:space:]].*|color13 ${COLOR_PINK}|" \
    -e "s|^color6[[:space:]].*|color6  ${COLOR_TEAL}|" \
    -e "s|^color14[[:space:]].*|color14 ${COLOR_TEAL}|" \
    -e "s|^color7[[:space:]].*|color7  ${COLOR_SUBTEXT1}|" \
    -e "s|^color15[[:space:]].*|color15 ${COLOR_SUBTEXT0}|" \
    "$KITTY_CONF"

echo "Applied theme to Kitty"

# Signal Kitty to reload config if running
if pgrep -x kitty &>/dev/null; then
    kill -SIGUSR1 "$(pgrep -x kitty | head -1)" 2>/dev/null && echo "Reloaded Kitty"
fi
