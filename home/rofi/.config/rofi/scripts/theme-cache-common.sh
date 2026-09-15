#!/usr/bin/env bash

find_serpantinum_wallpaper() {
    local wallpaper_dir="$1"
    local monitor path_file source

    if command -v hyprctl >/dev/null && command -v jq >/dev/null; then
        monitor="$(hyprctl monitors -j 2>/dev/null | jq -r '.[] | select(.focused) | .name' 2>/dev/null)"
        path_file="$wallpaper_dir/current_$monitor"
        if [[ -n "$monitor" && -r "$path_file" ]]; then
            IFS= read -r source < "$path_file"
            [[ -f "$source" ]] && { printf '%s\n' "$source"; return 0; }
        fi
    fi

    source="$wallpaper_dir/current_wallpaper.png"
    [[ -f "$source" ]] && { printf '%s\n' "$source"; return 0; }

    for source in "$wallpaper_dir"/current_wallpaper_*.png; do
        [[ -f "$source" ]] && { printf '%s\n' "$source"; return 0; }
    done
    return 1
}

wallpaper_signature() {
    stat -Lc '%n|%s|%Y' "$1"
}
