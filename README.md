# MTProxy Docker Setup

This repository contains a Docker setup for running an MTProxy server. MTProto Proxy is a protocol designed for accessing Telegram where it might be blocked or restricted. This setup allows you to deploy your own MTProxy instance quickly and securely.

## Quick Start

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/telegramProxyDocker.git
   cd telegramProxyDocker
   ```

2. **Build the Docker image**:
   ```bash
   docker build -t mtproxy .
   ```

3. **Run the MTProxy container**:
   ```bash
   docker run -d --name mtproxy -p 443:443 -p 8888:8888 mtproxy
   ```

4. **Check the logs for the MTProxy secret**:
   ```bash
   docker logs mtproxy
   ```
   Look for the line that says "MTProxy Secret for Clients" and copy the secret.

## Connecting to Your MTProxy Server

To connect to your MTProxy server from the Telegram app, use the following details:

- **Server**: Your server's IP address or domain name
- **Port**: `443`
- **Secret**: The secret you copied from the container logs

You can manually enter these details in the Telegram app under Settings > Data and Storage > Proxy Settings > Add Proxy, or use a configuration URL formatted as follows:
```
tg://proxy?server=YOUR_SERVER_IP&port=443&secret=YOUR_PROXY_SECRET
```

Replace `YOUR_SERVER_IP` with your server's IP address and `YOUR_PROXY_SECRET` with the MTProxy secret.

## Security Note

This MTProxy setup uses port 443 to help with obfuscation and ensure the proxy is accessible even in restrictive networks. The MTProto proxy protocol encrypts data, providing secure communication.

## Contributing
Contributions to this project are welcome! Please submit issues and pull requests with any improvements or bug fixes.
