#!/bin/sh
export MOZ_ENABLE_WAYLAND=1
export CLUTTER_BACKEND=wayland
export QT_QPA_PLATFORM=wayland-egl
export ECORE_EVAS_ENGINE=wayland-egl
export ELM_ENGINE=wayland-eql
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_VM_NONREPARENTING=1
export NO_AT_BRIDGE=1
