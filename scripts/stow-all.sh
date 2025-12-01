#!/bin/bash

set -e

STOWLIST="$1"

if [[ -z "$STOWLIST" ]]; then
    echo "Usage: stow-all <stowlist-file>"
    exit 1
fi

if [[ ! -f "$STOWLIST" ]]; then
    echo "Error: Stowlist file '$STOWLIST' not found."
    exit 1
fi

stow_dirs=()

declare -A processed

process_stowlist() {
    local file="$1"
    if [[ ! -f "$file" ]]; then
        echo "Error: Included stowlist '$file' not found."
        exit 1
    fi

    while IFS= read -r line || [[ -n "$line" ]]; do
        line="${line%%#*}"  # Remove comments
        line="${line// /}"  # Remove spaces
        [[ -z "$line" ]] && continue  # Skip empty lines

        if [[ "$line" == include* ]]; then
            included_file="${line#include}"
            if [[ -z "${processed[$included_file]}" ]]; then
                processed[$included_file]=1
                process_stowlist "$included_file"
            fi
        else
            stow_dirs+=("$line")
        fi
    done < "$file"
}

process_stowlist "$STOWLIST"

for dir in "${stow_dirs[@]}"; do
    echo "Stowing: $dir"
    stow -v --target="$HOME" "$dir"
done
