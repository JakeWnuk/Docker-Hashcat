FROM nvidia/cuda:12.3.2-devel-ubuntu22.04

# Configuration
ENV HASHCAT_VERSION=v6.2.6
COPY launcher.sh /

# Installation
RUN apt-get update && apt-get install -y --no-install-recommends \
        ocl-icd-libopencl1 opencl-headers \
        clinfo pkg-config make clinfo build-essential git libcurl4-openssl-dev \
    libssl-dev zlib1g-dev libcurl4-openssl-dev libssl-dev tini; \
    rm -rf /var/lib/apt/lists/*; \
    git clone https://github.com/hashcat/hashcat.git && cd hashcat && git checkout ${HASHCAT_VERSION} && make install -j4

ENTRYPOINT ["/usr/bin/tini", "--", "/launcher.sh"]
WORKDIR /data
