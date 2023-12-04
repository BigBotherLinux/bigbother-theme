#! /usr/bin/env bash

inputDir=$1

declare -A sizes=(
    ['horizontal']="5120x2880 3840x2160 3200x2000 3200x1800 2560x1600 2560x1440 1920x1200 1920x1080 1680x1050 1600x1200 1440x900 1366x768 1280x1024 1280x800 1024x768 440x247"
    ['vertical']="720x1440 360x720 1080x1920"
)

mkdir -p build

for inputFile in "$inputDir"/*.png; do
    # Extract filename without extension
    filename=$(basename "$inputFile" .png)
    
    for orientation in "${!sizes[@]}"; do
        for res in ${sizes[$orientation]}; do
            outputFile="build/${filename}_${res}.png"
            convert "$inputFile" -crop "$res"+0+0 "$outputFile"
        done
    done
done