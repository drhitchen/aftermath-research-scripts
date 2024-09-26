#!/bin/bash

# Base directory
base_dir="./"

# Date pattern
date_pattern="2024-08-2[567]"

# Grep patterns
grep_pattern="/downloads/|eicar_test|guest|osascript|phish.html|phishing|sudo|swift|loginwindow.plist|system_profiler"
grep_ignore="aftermath_analysis|aftermath.log"

# Flag to search artifacts directory
search_artifacts=true

