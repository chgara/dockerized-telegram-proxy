#!/bin/bash

# Fetch the proxy secret and config
curl -s https://core.telegram.org/getProxySecret -o /MTProxy/proxy-secret
curl -s https://core.telegram.org/getProxyConfig -o /MTProxy/proxy-multi.conf

# Use the predefined secret or generate one if not set or read it from the file secret.txt
if [ -z "$MT_PROXY_SECRET" ]; then
    if [ -f /MTProxy/secret.txt ]; then
      SECRET=$(cat /MTProxy/secret.txt)
    else
      SECRET=$(head -c 16 /dev/urandom | xxd -ps)
    fi
else
    SECRET=$MT_PROXY_SECRET
fi


# Log the secret or output to console
echo "=========================================="
echo "== MTProxy Secret for Clients: $SECRET  =="
echo "=========================================="
# Log to a file
echo $SECRET > /MTProxy/secret.txt

# Start the MTProxy with the secret (and any additional parameters passed to docker run)
/MTProxy/objs/bin/mtproto-proxy --aes-pwd /MTProxy/proxy-secret /MTProxy/proxy-multi.conf -M 1 -P ${TAG-"417b95b73907ce533fdeaff5c7ac2a3c"} -S $SECRET -p 8888 -H 443
