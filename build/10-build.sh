#!/usr/bin/bash

set -eoux pipefail

###############################################################################
# Main Build Script
###############################################################################
# This script follows the @ublue-os/bluefin pattern for build scripts.
# It uses set -eoux pipefail for strict error handling and debugging.
###############################################################################

# Source helper functions
# shellcheck source=/dev/null
source /ctx/build/copr-helpers.sh

echo "::group:: Copy Custom Files"

# Copy Brewfiles to standard location
# mkdir -p /usr/share/ublue-os/homebrew/
# cp /ctx/custom/brew/*.Brewfile /usr/share/ublue-os/homebrew/
#
# # Consolidate Just Files
# mkdir -p /usr/share/ublue-os/just/
# find /ctx/custom/ujust -iname '*.just' -exec printf "\n\n" \; -exec cat {} \; >> /usr/share/ublue-os/just/60-custom.just

# Copy Flatpak preinstall files
mkdir -p /etc/flatpak/preinstall.d/
cp /ctx/custom/flatpaks/*.preinstall /etc/flatpak/preinstall.d/

echo "::endgroup::"

echo "::group:: Install Packages"

# Install packages using dnf5
# Example: dnf5 install -y tmux

# Example using COPR with isolated pattern:
# copr_install_isolated "ublue-os/staging" package-name

dnf5 install -y             \
    tmux                    \
    util-linux              \
    chezmoi                 \
    neovim                  \
    btop                    \
    zsh                     \
    virt-viewer             \
    zsh-autosuggestions     \
    zsh-syntax-highlighting \
    steam                   \
    mangohud                \
    gamescope

# install noisetorch
copr_install_isolated "lochnair/NoiseTorch" \
    noisetorch

echo "::endgroup::"

echo "::group:: System Configuration"

# Enable/disable systemd services
systemctl enable podman.socket
# Example: systemctl mask unwanted-service

echo "::endgroup::"

echo "::group:: Run Cosmic Desktop install"

source /ctx/build/20-cosmic-desktop.sh

echo "::endgroup::"

echo "::group:: Run Hyprland install"

source /ctx/build/30-hyprland.sh

echo "::endgroup::"

echo "Custom build complete!"
