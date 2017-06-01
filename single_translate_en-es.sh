#!/bin/bash
# Translate a txt file from english to spanish using trans (https://github.com/soimort/translate-shell)

# Set IFS so that it won't consider spaces as entry separators.  Without this, spaces in file/folder names can make the loop go wacky.
IFS=$'\n'

# See if the Nautilus environment variable is empty
if [ -z $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS ]; then
    # If it's blank, set it equal to $1
    NAUTILUS_SCRIPT_SELECTED_FILE_PATHS=$1
fi

trans :es -no-auto -b -i "$NAUTILUS_SCRIPT_SELECTED_FILE_PATHS" -o "${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS%.*}_es.txt"
sed -i 's/ null//g' "${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS%.*}_es.txt"
sed -i 's/ Unesdoc.unesco.org unesdoc.unesco.org//g' "${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS%.*}_es.txt"

if [ $? -eq 0 ]; then
    notify-send -t 5000 -i /usr/share/icons/gnome/32x32/status/info.png "${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS%.*}_es.txt Created"
else
    notify-send -t 5000 -i /usr/share/icons/gnome/32x32/status/info.png "${NAUTILUS_SCRIPT_SELECTED_FILE_PATHS%.*}_es.txt Failed"
fi

