#!/bin/bash

# Taken from:
# https://www.notion.so/Yabai-8da3b829872d432fac43181b7ff628fc

window_id=$(yabai -m query --windows --window | jq -re '.id')
echo "found window $window_id"

yabai -m window --display prev || yabai -m window --display last

yabai -m window --focus $window_id
