#!/bin/bash
## **Evil laugh** This script updates the hotspot coordinates of all cursor files in the directory to be bottom right corner.
## Generated with ChatGPT

## Directory where your cursor theme is located
cursor_theme_directory="./src/config"

# Loop over all .cursor files in the directory
for cursor_file in "$cursor_theme_directory"/*.cursor; do
    echo "Processing $cursor_file..."

    # Read each line in the cursor file
    while read -r line; do
        # Extract the dimensions and file path
        dimensions=$(echo $line | awk '{print $1}')
        file_path=$(echo $line | awk '{print $4}')

        # Calculate new hotspot coordinates (width - 1, height - 1)
        hotspot_x=$(($dimensions - 1))
        hotspot_y=$(($dimensions - 1))

        # Write the new line with updated hotspot coordinates
        echo "$dimensions $hotspot_x $hotspot_y $file_path" >> "${cursor_file}.new"
    done < "$cursor_file"

    # Replace the old cursor file with the new one
    mv "${cursor_file}.new" "$cursor_file"
    echo "Updated $cursor_file"
done

echo "All cursor files have been updated."
