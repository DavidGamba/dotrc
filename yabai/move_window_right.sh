#!/bin/bash

# Taken from:
# https://www.notion.so/Yabai-8da3b829872d432fac43181b7ff628fc

echo "Moving window to right"
window_id=$(yabai -m query --windows --window | jq -re '.id')
display_id=$(yabai -m query --windows --window | jq -re '.display')
echo "  found window $window_id on display $display_id"

yabai -m window --display next || echo "  trying display first" ; yabai -m window --display first

echo "  focus window $window_id"
yabai -m window --focus $window_id
