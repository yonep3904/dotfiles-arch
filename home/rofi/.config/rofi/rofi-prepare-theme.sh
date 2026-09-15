#!/usr/bin/env bash

# Prepare shared visual assets only. Rofi invocation belongs to each UI's own script.
set -eu

readonly config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/rofi"
readonly cache_dir="$HOME/.cache/rofi-serpantinum"
readonly serpantinum_dir="$HOME/.cache/serpantinum/wallpaper"
readonly regenerator="$config_dir/scripts/regenerate-theme-cache.sh"

# shellcheck source=theme-cache-common.sh
source "$config_dir/scripts/theme-cache-common.sh"

mkdir -p "$cache_dir"

cache_is_current=false
if source_image="$(find_serpantinum_wallpaper "$serpantinum_dir")" &&
   signature="$(wallpaper_signature "$source_image")" &&
   [[ -s "$cache_dir/wallpaper.png" && -s "$cache_dir/colors.rasi" ]] &&
   [[ -r "$cache_dir/wallpaper.signature" ]] &&
   IFS= read -r cached_signature < "$cache_dir/wallpaper.signature" &&
   [[ "$signature" == "$cached_signature" ]]; then
    cache_is_current=true
fi

if ! $cache_is_current; then
    # Automatic regeneration is best-effort and preserves an existing good cache.
    "$regenerator" || true
fi

# First-run fallback. Do not create a signature: a later invocation should retry.
[[ -s "$cache_dir/wallpaper.png" ]] || cp -f "$config_dir/images/e.jpg" "$cache_dir/wallpaper.png"
[[ -s "$cache_dir/colors.rasi" ]] || cp -f "$config_dir/themes/fallback-colors.rasi" "$cache_dir/colors.rasi"
