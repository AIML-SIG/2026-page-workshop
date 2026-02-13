#!/bin/bash
set -e

# Update package lists (ignore gpg warnings from unsigned repos)
apt-get update -o APT::Get::AllowUnauthenticated=true || true

# Install R
echo "Installing R..."
apt-get install -y --no-install-recommends r-base r-base-dev

# Install R packages
echo "Installing R packages..."
R -e "install.packages(c('tidyverse', 'ggplot2', 'rmarkdown', 'devtools', 'IRkernel', 'knitr'), repos='https://cloud.r-project.org/')"
R -e "IRkernel::installspec(user = FALSE)"

# Install Python packages
echo "Installing Python packages..."
pip install --upgrade pip
pip install numpy pandas scipy matplotlib seaborn scikit-learn statsmodels jupyter jupyterlab ipywidgets

# Install Julia packages (Julia installed by install-julia.sh)
if command -v julia &> /dev/null; then
    echo "Installing Julia packages..."
    julia -e 'using Pkg; Pkg.add(["IJulia", "Plots", "StatsPlots", "DataFrames", "CSV", "Statistics", "Distributions"])'
fi

echo "Setup complete!"
