#!/usr/bin/bash

set -eoux pipefail

# Source helper functions
# shellcheck source=/dev/null
source /ctx/build/copr-helpers.sh

echo "::group:: Install Hyprland"

# Install hyprland from COPR
copr_install_isolated "solopasha/hyprland" \
    hyprland            \
    hyprpaper           \
    hyprpicker          \
    hypridle            \
    hyprlock            \
    hyprsunset          \
    hyprpolkitagent     \
    hyprsysteminfo      \
    qt6ct-kde           \
    hyprland-qt-support \
    hyprland-qtutils

echo "Hyprland installed successfully"
echo "::endgroup::"

echo "::group:: Install Additional Utilities"

# Install additional utilities that work well with WMs
dnf5 install -y             \
    waybar                  \
    kitty                   \
    pipewire                \
    pavucontrol             \
    nm-connection-editor    \
    rofi                    \
    brightnessctl           \
    blueman                 \
    network-manager-applet  \
    wl-gammactl             \
    breeze-cursor-theme     \
    gtk-murrine-engine      \
    gnome-themes-extra

# install nwg-look
copr_install_isolated "njkevlani/nwg-look" \
    nwg-look

echo "Additional utilities installed"
echo "::endgroup::"

echo "Hyplrand installation complete!"
echo "After booting, select 'Hyprland' session at the login screen"
