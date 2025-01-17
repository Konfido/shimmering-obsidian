#!/bin/zsh
export PATH=/usr/local/bin/:/opt/homebrew/bin/:$PATH

# OCR
temp_image="$alfred_workflow_cache""/temp_ocr_snapshot.png"
mkdir -p "$alfred_workflow_cache"
screencapture -i "$temp_image"
ocr_text=$(tesseract "$temp_image" stdout -l $ocr_languages 2>&1)
ocr_prefix="$*" # has to be input from Alfred for date variable resolution
ocr_text="$ocr_prefix""\n\n""$ocr_text"

# if using multiple monitors
ocr_text=$(echo "$ocr_text" | egrep -v "Warning: Invalid resolution 0 dpi." | egrep -v "Estimating resolution as")

# Write to file
vaultPath="${vault_path/#\~/$HOME}"
if [[ "$ocr_screenshot_file" == "" ]] ; then
	ocr_screenshot_file="$vaultPath""/OCR-Screenshots.md"
else
	ocr_screenshot_file="${ocr_screenshot_file/#\~/$HOME}"
fi
parent_folder="${ocr_screenshot_file%/*}"
mkdir -p "$parent_folder"
echo "$ocr_text" >> "$ocr_screenshot_file"

# to open in Obsidian
echo -n "$ocr_screenshot_file"

