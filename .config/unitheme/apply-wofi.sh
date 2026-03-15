#!/bin/bash
# Apply unitheme to Wofi app launcher

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/theme.conf"

WOFI_CSS="${HOME}/.config/wofi/style.css"

if [[ ! -d "$(dirname "$WOFI_CSS")" ]]; then
    echo "Wofi config directory not found"
    exit 1
fi

# Convert #RRGGBB to rgba(R, G, B, alpha)
hex_to_rgba() {
    local hex="${1#'#'}"
    local r=$((16#${hex:0:2}))
    local g=$((16#${hex:2:2}))
    local b=$((16#${hex:4:2}))
    echo "rgba($r, $g, $b, ${2:-1.0})"
}

WOFI_BG_RGBA=$(hex_to_rgba "$WOFI_BG" "0.9")
WOFI_SURFACE_RGBA=$(hex_to_rgba "$WOFI_SELECTED_BG" "0.9")

cat > "$WOFI_CSS" << EOF
* {
	font-family: CALICOMP;
	font-size: 20
}

window {
	background-color: ${WOFI_BG_RGBA};
	border-left: 2px solid ${WOFI_BORDER_COLOR};
	border-right: 2px solid ${WOFI_BORDER_COLOR};
	border-top: 2px solid ${WOFI_BORDER_COLOR};
	border-bottom: 2px solid ${WOFI_BORDER_COLOR};
	border-radius: 0px;
}

#input {
	color: ${WOFI_TEXT};
	background-color: ${WOFI_SURFACE_RGBA};
	border-radius: 0px;
	border-color: ${WOFI_BORDER_COLOR};
}

#entry:selected {
	background-color: ${WOFI_SELECTED_BG};
	border-left: 2px solid ${WOFI_SELECTED_BORDER};
	border-right: 2px solid ${WOFI_SELECTED_BORDER};
	border-top: 2px solid ${WOFI_SELECTED_BORDER};
	border-bottom: 2px solid ${WOFI_SELECTED_BORDER};
}
EOF

echo "Applied theme to Wofi"
