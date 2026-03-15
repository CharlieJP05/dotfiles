#!/bin/bash
# Apply unitheme to wlogout logout menu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/theme.conf"

WLOGOUT_CSS="${HOME}/.config/wlogout/style.css"

if [[ ! -d "$(dirname "$WLOGOUT_CSS")" ]]; then
    echo "wlogout config directory not found"
    exit 1
fi

cat > "$WLOGOUT_CSS" << EOF
*  {
	background-image: none;
	box-shadow: none;
}

window {
	background-color: ${WLOGOUT_WINDOW_BG};
}

button {
    border-radius: 15;
	margin: 8px;
    border-color: black;
	text-decoration-color: ${WLOGOUT_BUTTON_TEXT};
    color: ${WLOGOUT_BUTTON_TEXT};
	background-color: ${WLOGOUT_BUTTON_BG};
	border-style: solid;
	border-width: 0px;
	background-repeat: no-repeat;
	background-position: center;
	background-size: 25%;
}

button:focus, button:active, button:hover {
	background-color: ${WLOGOUT_BUTTON_HOVER};
	outline-style: none;
}

#lock {
    background-image: image(url("/usr/share/wlogout/icons/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));
}

#logout {
    background-image: image(url("/usr/share/wlogout/icons/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
}

#suspend {
    background-image: image(url("/usr/share/wlogout/icons/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
}

#hibernate {
    background-image: image(url("/usr/share/wlogout/icons/hibernate.png"), url("/usr/local/share/wlogout/icons/hibernate.png"));
}

#shutdown {
    background-image: image(url("/usr/share/wlogout/icons/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
}

#reboot {
    background-image: image(url("/usr/share/wlogout/icons/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
}
EOF

echo "Applied theme to wlogout"
