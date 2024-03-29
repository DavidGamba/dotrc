#!/bin/bash

# Remove existing entries to ensure the right one is loaded
# This is not required when the completion one liner is loaded in your bashrc.
complete -r ./build 2>/dev/null

complete -o default -C "$PWD/build" build

export PATH=$PATH:$PWD
