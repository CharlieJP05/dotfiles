#!/bin/bash
# Apply unitheme to btop system monitor by regenerating its theme file

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/theme.conf"

BTOP_THEME="${HOME}/.config/btop/themes/catppuccin_macchiato.theme"

if [[ ! -d "$(dirname "$BTOP_THEME")" ]]; then
    echo "btop themes directory not found"
    exit 1
fi

# btop theme files use uppercase hex values
cat > "$BTOP_THEME" << EOF
theme[main_bg]="${COLOR_BASE^^}"
theme[main_fg]="${COLOR_TEXT^^}"
theme[title]="${COLOR_TEXT^^}"
theme[hi_fg]="${COLOR_BLUE^^}"
theme[selected_bg]="${COLOR_SURFACE1^^}"
theme[selected_fg]="${COLOR_BLUE^^}"
theme[inactive_fg]="${COLOR_OVERLAY1^^}"
theme[graph_text]="${COLOR_ROSEWATER^^}"
theme[meter_bg]="${COLOR_SURFACE1^^}"
theme[proc_misc]="${COLOR_ROSEWATER^^}"
theme[cpu_box]="${COLOR_SAPPHIRE^^}"
theme[mem_box]="${COLOR_GREEN^^}"
theme[net_box]="${COLOR_MAUVE^^}"
theme[proc_box]="${COLOR_FLAMINGO^^}"
theme[div_line]="${COLOR_OVERLAY0^^}"
theme[temp_start]="${COLOR_YELLOW^^}"
theme[temp_mid]="${COLOR_PEACH^^}"
theme[temp_end]="${COLOR_RED^^}"
theme[cpu_start]="${COLOR_SAPPHIRE^^}"
theme[cpu_mid]="${COLOR_SKY^^}"
theme[cpu_end]="${COLOR_TEAL^^}"
theme[free_start]="${COLOR_TEAL^^}"
theme[free_mid]="${COLOR_TEAL^^}"
theme[free_end]="${COLOR_GREEN^^}"
theme[cached_start]="${COLOR_PINK^^}"
theme[cached_mid]="${COLOR_PINK^^}"
theme[cached_end]="${COLOR_MAUVE^^}"
theme[available_start]="${COLOR_ROSEWATER^^}"
theme[available_mid]="${COLOR_FLAMINGO^^}"
theme[available_end]="${COLOR_FLAMINGO^^}"
theme[used_start]="${COLOR_PEACH^^}"
theme[used_mid]="${COLOR_PEACH^^}"
theme[used_end]="${COLOR_RED^^}"
theme[download_start]="${COLOR_LAVENDER^^}"
theme[download_mid]="${COLOR_LAVENDER^^}"
theme[download_end]="${COLOR_MAUVE^^}"
theme[upload_start]="${COLOR_LAVENDER^^}"
theme[upload_mid]="${COLOR_LAVENDER^^}"
theme[upload_end]="${COLOR_MAUVE^^}"
theme[process_start]="${COLOR_SAPPHIRE^^}"
theme[process_mid]="${COLOR_SKY^^}"
theme[process_end]="${COLOR_TEAL^^}"
EOF

echo "Applied theme to btop"
