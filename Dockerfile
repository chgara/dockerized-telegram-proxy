# Use Ubuntu 20.04 LTS as the base image
FROM ubuntu:20.04

# Set working directory
WORKDIR /MTProxy

# Avoid prompts from apt
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt update && \
    apt install -y git curl build-essential libssl-dev zlib1g-dev vim-common && \
    rm -rf /var/lib/apt/lists/*

# Clone the MTProxy repository
RUN git clone https://github.com/TelegramMessenger/MTProxy . && \
    make && \
    cd objs/bin

# Create a dedicated user for MTProxy
RUN groupadd -r mtproxy && useradd -r -g mtproxy -d /MTProxy -s /bin/false mtproxy

# Change ownership of the MTProxy directory
RUN chown -R mtproxy:mtproxy /MTProxy

# Expose ports (Assuming default settings, modify as needed)
EXPOSE 443
EXPOSE 8888

# Entry point script
# This will handle fetching the proxy configuration, setting up secrets, and starting the MTProxy
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Command to run MTProxy - The actual secrets and configurations are handled in the entrypoint script.
CMD ["./mtproto-proxy", "-u", "mtproxy", "-p", "8888", "-H", "443", "--aes-pwd", "proxy-secret", "proxy-multi.conf", "-M", "1"]
