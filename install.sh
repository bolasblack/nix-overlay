#!/usr/bin/env bash

NAME=${OVERLAY_NAME:-c4605-overlay.nix}
OVERLAY_DIR=${OVERLAY_DIR:-${HOME}/.config/nixpkgs/overlays}

echo "Installing overlay as ${NAME} to ${OVERLAY_DIR}"

set -xe

cd "$(dirname "$0")" || exit
mkdir -p "${OVERLAY_DIR}"
ln -s "${PWD}/default.nix" "${OVERLAY_DIR}/${NAME}"
