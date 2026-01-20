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

# Set workdir
WORKDIR /src
# get the source code
RUN git clone https://github.com/STMicroelectronics/gnu-tools-for-stm32.git && \
    cd gnu-tools-for-stm32 && \
    git checkout 14.3.rel1 && \
# Build toolchain
    ./build-toolchain.sh --build_type=native \
    --skip_steps=manual,mingw,mingw32,mingw-gdb-with-python,mingw32-gdb-with-python,package_sources

# Default command
CMD ["/bin/bash"]
