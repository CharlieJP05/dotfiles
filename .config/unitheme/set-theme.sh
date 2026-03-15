#!/bin/bash
# Apply the unified theme to all configured applications.
# To add support for a new application, create apply-<appname>.sh
# in this directory and it will be automatically picked up.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Applying unitheme..."

for script in "$SCRIPT_DIR"/apply-*.sh; do
    if [[ -f "$script" ]]; then
        echo "  → $(basename "$script")"
        bash "$script"
    fi
done

echo "Done."
