# Use the latest Debian image as the base
FROM debian:latest

# Set environment variables to avoid prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    build-essential \
    cmake \
    g++ \
    libjson-c-dev \  
    libuv1-dev \      
    zlib1g-dev \
    libwebsockets-dev \     
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install TTYD
RUN git clone --recurse-submodules https://github.com/tsl0922/ttyd.git && \
    cd ttyd && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf ttyd

# Clone the Vaim-sms repository
RUN git clone https://github.com/VaimpierOfficial/Vaim-sms.git

# Install required Python packages
RUN pip3 install requests

# Set the working directory
WORKDIR /Vaim-sms

# Expose the port for TTYD
EXPOSE 10000

# Setup command to start TTYD with Python script
CMD ["bash", "-c", "ttyd -p 10000 python3 Vaim-sms.py"]
