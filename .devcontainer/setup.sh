#!/bin/bash
set -e

# Add R project Ubuntu repository for newer R version
echo "Adding R repository..."
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 2>&1 | grep -v "Warning"
sudo sh -c 'echo "deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/" > /etc/apt/sources.list.d/r-ubuntu.list'

# Update package lists (ignore gpg warnings from unsigned repos)
sudo apt-get update -o APT::Get::AllowUnauthenticated=true || true

# Install R
echo "Installing R..."
sudo apt-get install -y --no-install-recommends r-base r-base-dev

# Clean old R packages from previous installation
echo "Cleaning old R packages..."
sudo rm -rf /usr/local/lib/R/site-library

# Install R packages
echo "Installing R packages..."
sudo R -e "install.packages(c('ggplot2'), repos='https://cloud.r-project.org/')"

echo "Setup complete!"
