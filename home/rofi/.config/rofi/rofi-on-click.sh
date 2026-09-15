#!/usr/bin/env bash

set -u

if (( $# != 1 )); then
    echo "Usage: $(basename "$0") <name>" >&2
    exit 2
fi

name="$1"

if [[ ! "$name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    exit 2
fi

runtime_dir="${XDG_RUNTIME_DIR:-/tmp}/rofi-toggle-$UID"
pidfile="$runtime_dir/$name.pid"

# Fast path:
# If the target Rofi is not running, do not call hyprctl / jq.
[[ -f "$pidfile" ]] || exit 0

launcher_pid=$(<"$pidfile")

if [[ ! "$launcher_pid" =~ ^[0-9]+$ ]] ||
   ! kill -0 "$launcher_pid" 2>/dev/null; then
    rm -f "$pidfile"
    exit 0
fi

cursor="$(
    hyprctl cursorpos -j 2>/dev/null |
        jq -r '[.x, .y] | @tsv'
)" || exit 0

rects="$(
    hyprctl layers -j 2>/dev/null |
        jq -r --arg pid "$launcher_pid" '
            .. | objects
            | select(.namespace? == "rofi")
            | select((.pid? | tostring) == $pid)
            | select(
                .x? != null and
                .y? != null and
                (.w? // .width?) != null and
                (.h? // .height?) != null
            )
            | [.x, .y, (.w // .width), (.h // .height)]
            | @tsv
        '
)" || exit 0

# If the geometry cannot be obtained, exit safely and do nothing.
[[ -n "$rects" ]] || exit 0

read -r cursor_x cursor_y <<< "$cursor"

while IFS=$'\t' read -r layer_x layer_y layer_w layer_h; do
    if (( cursor_x >= layer_x &&
          cursor_x <  layer_x + layer_w &&
          cursor_y >= layer_y &&
          cursor_y <  layer_y + layer_h )); then
        exit 0
    fi
done <<< "$rects"

# All Rofi layers were outside.
kill "$launcher_pid" 2>/dev/null || true
