#!/bin/bash

# Default values (optional)
name=""
season=""
chapter=""

# Parse command-line arguments
while getopts "n:s:c:" opt; do
  case $opt in
    n) name="$OPTARG" ;;    # Anime name
    s) season="$OPTARG" ;;  # Season number
    c) chapter="$OPTARG" ;; # Chapter number
    *) echo "Usage: $0 -n [anime name] -s [season number] -c [chapter]" >&2
       exit 1 ;;
  esac
done

# Check required arguments
if [[ -z "$name" || -z "$season" || -z "$chapter" ]]; then
  echo "Error: Missing arguments!"
  echo "Usage: $0 -n [anime name] -s [season number] -c [chapter]"
  exit 1
fi

# Expand ~ to home properly
base_dir="$HOME/Documents/Animes/$name/$season"

# Get files into array
files=("$base_dir"/*)
file_array=()
for f in "${files[@]}"; do
    [[ -f "$f" ]] && file_array+=("$f")
done

# Calculate index (chapter starts from 1)
index=$((chapter-1))
selected_file="${file_array[$index]}"

# Get filename
filename=$(basename "$selected_file")

# Play with VLC
vlc "$base_dir/$filename"

