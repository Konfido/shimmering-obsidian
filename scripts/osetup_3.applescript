#!/usr/bin/env osascript

# restart Obsidian
tell application "Obsidian" to if it is running then quit
delay 0.2
repeat until application "Obsidian" is not running
	delay 0.2
end repeat
delay 1

# dump metadata
set vaultName to (system attribute "vault_name_ENC")
set prefix to "obsidian://advanced-uri?vault=" & vaultName & "&commandid=metadata-extractor%253A"
tell application "Obsidian"
	activate
	open location (prefix & "write-metadata-json")
	open location (prefix & "write-tags-json")
	open location (prefix & "write-allExceptMd-json")
end tell