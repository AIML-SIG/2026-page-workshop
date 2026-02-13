#!/bin/bash

# Install common R packages
echo "Installing R packages..."
R -e "install.packages(c('tidyverse', 'rmarkdown', 'devtools', 'IRkernel'), repos='https://cloud.r-project.org/')"
R -e "IRkernel::installspec(user = FALSE)"

# Install common Python packages
echo "Installing Python packages..."
pip install --upgrade pip
pip install numpy pandas matplotlib seaborn scikit-learn jupyter jupyterlab

# Install common Julia packages
echo "Installing Julia packages..."
julia -e 'using Pkg; Pkg.add(["IJulia", "Plots", "DataFrames", "CSV"])'

echo "Setup complete!"
