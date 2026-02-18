# Load the base image with R
FROM ghcr.io/rocker-org/devcontainer/r-ver:4

USER root

# Avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system packages needed for R, Python, and building some R packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       wget ca-certificates tar gnupg2 build-essential libcurl4-openssl-dev \
       libssl-dev libxml2-dev libffi-dev libfontconfig1-dev libfreetype6-dev \
       libpng-dev libjpeg-dev git python3-pip python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Optionally install R packages at build time via the `R_PACKAGES` build-arg (comma-separated)
ARG R_PACKAGES="ggplot2"
ENV R_PACKAGES="$R_PACKAGES"
RUN if [ -n "$R_PACKAGES" ]; then \
      R -e "options(repos = c(CRAN = 'https://cloud.r-project.org')); pkgs <- strsplit(Sys.getenv('R_PACKAGES'), ',')[[1]]; install.packages(trimws(pkgs), dependencies=TRUE)"; \
    fi

## Install Python into a virtual environment to avoid PEP 668 errors
#RUN python3 -m venv /opt/venv \
#    && /opt/venv/bin/python -m pip install --no-cache-dir --upgrade pip setuptools wheel

## Optionally install Python packages at build time via the `PYTHON_PACKAGES` build-arg (comma-separated)
#ARG PYTHON_PACKAGES="numpy"
#ENV PYTHON_PACKAGES="$PYTHON_PACKAGES"
#RUN if [ -n "$PYTHON_PACKAGES" ]; then \
#      PKGS=$(echo "$PYTHON_PACKAGES" | tr ',' '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | sed '/^$/d' | tr '\n' ' '); \
#      if [ -n "$PKGS" ]; then /opt/venv/bin/python -m pip install --no-cache-dir $PKGS; fi; \
#    fi

#ENV PATH="/opt/venv/bin:${PATH}"

# Install Julia (binary)
ARG JULIA_VERSION=1.10.0
RUN wget -q https://julialang-s3.julialang.org/bin/linux/x64/1.10/julia-${JULIA_VERSION}-linux-x86_64.tar.gz \
    && tar -xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz \
    && mv julia-${JULIA_VERSION} /opt/julia \
    && ln -s /opt/julia/bin/julia /usr/local/bin/julia \
    && rm julia-${JULIA_VERSION}-linux-x86_64.tar.gz

# Use a shared Julia depot so packages/registries installed at build time are available to non-root users
ENV JULIA_DEPOT_PATH=/usr/local/share/julia
RUN mkdir -p ${JULIA_DEPOT_PATH} && chmod -R 0777 ${JULIA_DEPOT_PATH}

# Install common Julia packages (optionally via the `JULIA_PACKAGES` build-arg)
ARG JULIA_PACKAGES="CSV"
ENV JULIA_PACKAGES="$JULIA_PACKAGES"
RUN if [ -n "$JULIA_PACKAGES" ]; then \
            julia -e 'using Pkg; try Pkg.Registry.add(Pkg.RegistrySpec(url="https://github.com/JuliaRegistries/General.git")) catch end; pkgs = split(ENV["JULIA_PACKAGES"], ","); for p in pkgs; pn = strip(p); if pn != ""; Pkg.add(pn); end; end; Pkg.precompile()'; \
        fi

# Create a writable R library directory for non-root users
RUN mkdir -p /home/vscode/R && chmod 0777 /home/vscode/R || true

ENV PATH="/opt/julia/bin:${PATH}"
