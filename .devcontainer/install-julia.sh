#!/bin/bash
set -e

# Install Julia from Ubuntu repositories
echo "Installing Julia..."
apt-get install -y --no-install-recommends julia

echo "Julia installed successfully"
julia --version
