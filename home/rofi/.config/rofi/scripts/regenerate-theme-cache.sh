#!/usr/bin/env bash

# Forced, strict cache regeneration. This script never falls back.
set -euo pipefail

readonly config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/rofi"
readonly cache_dir="$HOME/.cache/rofi-serpantinum"
readonly serpantinum_dir="$HOME/.cache/serpantinum/wallpaper"
readonly generated_colors="$cache_dir/colors.generated.rasi"

# shellcheck source=theme-cache-common.sh
source "$config_dir/scripts/theme-cache-common.sh"

for dependency in ffmpeg matugen flock stat; do
    if ! command -v "$dependency" >/dev/null; then
        printf 'regenerate-theme-cache: required command not found: %s\n' "$dependency" >&2
        exit 1
    fi
done

source_image="$(find_serpantinum_wallpaper "$serpantinum_dir")" || {
    printf 'regenerate-theme-cache: Serpantinum wallpaper was not found in %s\n' "$serpantinum_dir" >&2
    exit 1
}
signature="$(wallpaper_signature "$source_image")" || {
    printf 'regenerate-theme-cache: cannot inspect wallpaper: %s\n' "$source_image" >&2
    exit 1
}

mkdir -p "$cache_dir"
exec 9>"$cache_dir/refresh.lock"
flock 9

tmp_image="$cache_dir/wallpaper.$$.png"
tmp_signature="$cache_dir/wallpaper.signature.$$"
cleanup() {
    rm -f "$tmp_image" "$tmp_signature" "$generated_colors"
}
trap cleanup EXIT

ffmpeg -hide_banner -loglevel error -y -i "$source_image" \
    -vf 'scale=720:240:force_original_aspect_ratio=disable,gblur=sigma=18:steps=2' \
    -frames:v 1 "$tmp_image"
[[ -s "$tmp_image" ]] || { printf 'regenerate-theme-cache: ffmpeg produced no image\n' >&2; exit 1; }

rm -f "$generated_colors"
matugen image "$source_image" --mode dark --type scheme-tonal-spot \
    --source-color-index 0 --config "$config_dir/matugen.toml" --quiet
[[ -s "$generated_colors" ]] || { printf 'regenerate-theme-cache: Matugen produced no color file\n' >&2; exit 1; }

mv -f "$tmp_image" "$cache_dir/wallpaper.png"
mv -f "$generated_colors" "$cache_dir/colors.rasi"
printf '%s\n' "$signature" > "$tmp_signature"
mv -f "$tmp_signature" "$cache_dir/wallpaper.signature"

trap - EXIT
printf 'Regenerated shared Rofi theme cache from %s\n' "$source_image"
