#!/bin/bash
hyprctl activewindow -j | jq .class | tr -d '"'