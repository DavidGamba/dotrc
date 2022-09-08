#!/bin/bash

# Taken from:
# https://www.notion.so/Yabai-8da3b829872d432fac43181b7ff628fc

echo "Moving window to left"
window_id=$(yabai -m query --windows --window | jq -re '.id')
display_id=$(yabai -m query --windows --window | jq -re '.display')
echo "  found window $window_id on display $display_id"

yabai -m window --display prev || echo "  trying display last" ; yabai -m window --display last

echo "  focus window $window_id"
yabai -m window --focus $window_id

echo "  focus window $window_id"
yabai -m window --focus $window_id
