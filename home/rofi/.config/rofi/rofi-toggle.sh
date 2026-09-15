#!/usr/bin/env bash

set -u

if (( $# < 2 )); then
    echo "Usage: $(basename "$0") <name> <command> [args...]" >&2
    exit 2
fi

name="$1"
shift

# Allow only safe names for the PID file.
if [[ ! "$name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "Invalid name: $name" >&2
    exit 2
fi

runtime_dir="${XDG_RUNTIME_DIR:-/tmp}/rofi-toggle-$UID"
pidfile="$runtime_dir/$name.pid"

mkdir -p "$runtime_dir"

if [[ -f "$pidfile" ]]; then
    pid=$(<"$pidfile")

    if [[ "$pid" =~ ^[0-9]+$ ]] && kill -0 "$pid" 2>/dev/null; then
        kill "$pid"
        exit 0
    fi

    # stale PID file
    rm -f "$pidfile"
fi

"$@" &
pid=$!

printf '%s\n' "$pid" > "$pidfile"

wait "$pid"
status=$?

# If another process with the same name is already running, do not delete its PID file.
if [[ -f "$pidfile" ]] && [[ "$(<"$pidfile")" == "$pid" ]]; then
    rm -f "$pidfile"
fi

exit "$status"
