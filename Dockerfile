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

# Install GateOne
RUN pip3 install GateOne

# Clone the Vaim-sms repository
RUN git clone https://github.com/VaimpierOfficial/Vaim-sms.git

# Install required Python packages for your application, if any
RUN pip3 install requests

# Set the working directory
WORKDIR /Vaim-sms

# Expose the port for GateOne (default is 443)
EXPOSE 443

# Start GateOne with the specified configuration
CMD ["gateone"]
