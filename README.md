# openvpn-docker
Playground for testing OpenVPN configurations by running a VPN server and clients in Docker containers


Build
=====
```bash
# Build the openvpn image
make image

# Create all the certs
make keys [SERVER=mysername] [CLIENT=myclientname]
```

Run
===

```bash
# Start the server in one terminal
./server.sh

# Start the client in another terminal
./client.sh

# Test connection in another terminal
docker exec -it openvpn-client bash
$ curl https://google.com
```

Import
======

```bash
# Create more client certs
make client CLIENT=iphone
make client CLIENT=android

# Export client certs as PKCS12 (can be imported in OpenVPN-Connect app)
make p12 CLIENT=iphone

# Export client configuration as ovpn (to be imported in OpenVPN-Connect client)
make ovpn CLIENT=iphone

```

iPhone
======

Install openvpn-connect app
Import .ovpn and .p12 file (renamed as .ovpn12) (via google drive, email, dropbox, files etc)

ChromeOS
========

Install openvpn-connect app.
Import .ovpn and .p12 files.
Optionally, import the pki/ca.crt into chrome://certificate-manager
