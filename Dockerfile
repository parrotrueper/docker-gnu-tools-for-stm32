# syntax=docker/dockerfile:1
FROM debian:trixie

# build dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    bison \
    ca-certificates \
    curl \
    flex \
    gawk \
    git \
    texinfo \
    libexpat-dev \
    libgmp-dev \
    libisl-dev \
    libmpc-dev \
    libmpfr-dev \
    lbzip2 \
    python3 \
    wget \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
