CA=myca
SERVER=server
CLIENT=client

RUN=docker run --rm -it --volume "$(CURDIR):/etc/openvpn:rw" openvpn

.PHONY: image keys ca server client

image:
	DOCKER_BUILDKIT=1 docker build -t openvpn .

keys: ca server client

ca: pki/private/ca.key

server: pki/dh.pem ta.key pki/private/$(SERVER).key

client: ta.key pki/private/$(CLIENT).key

pki/private/ca.key:
	$(RUN) /usr/share/easy-rsa/easyrsa init-pki
	$(RUN) bash -c "echo $(CA) | /usr/share/easy-rsa/easyrsa build-ca nopass"

pki/dh.pem:
	$(RUN) /usr/share/easy-rsa/easyrsa gen-dh

ta.key:
	$(RUN) openvpn --genkey --secret ta.key

pki/private/$(SERVER).key:
	$(RUN) /usr/share/easy-rsa/easyrsa build-server-full $(SERVER) nopass

pki/private/$(CLIENT).key:
	$(RUN) /usr/share/easy-rsa/easyrsa build-client-full $(CLIENT) nopass


p12: client
	openssl pkcs12 -export -in pki/issued/$(CLIENT).crt -inkey pki/private/$(CLIENT).key -certfile pki/ca.crt -name $(CLIENT) -out $(CLIENT).p12

ovpn: client
	(egrep -v 'pki|ta.key' client.conf; echo "<ca>"; cat pki/ca.crt; echo "</ca>"; echo "<tls-auth>"; cat ta.key; echo "</tls-auth>") > $(CLIENT).ovpn

