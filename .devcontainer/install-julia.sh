#!/bin/bash
set -e

# Install Julia from official source
echo "Installing Julia..."
cd /tmp
wget -q https://julialang-s3.julialang.org/bin/linux/x64/1.10/julia-1.10.0-linux-x86_64.tar.gz
tar -xzf julia-1.10.0-linux-x86_64.tar.gz
sudo mv julia-1.10.0 /opt/julia
sudo ln -s /opt/julia/bin/julia /usr/local/bin/julia
rm julia-1.10.0-linux-x86_64.tar.gz

echo "Julia installed successfully"
julia --version

# Install Julia packages (Julia installed by install-julia.sh)
if command -v julia &> /dev/null; then
    echo "Installing Julia packages..."
    julia -e 'using Pkg; Pkg.add(["IJulia", "CSV"])'
fi

# Install Python packages
#echo "Installing Python packages..."
#pip install --upgrade pip
#pip install numpy pandas matplotlib seaborn jupyter jupyterlab ipywidgets
