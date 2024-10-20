# Running docker

```
mkdir /var/log/openvpn
#chown openvpn: /var/log/openvpn
```

```
# generate image
docker build . --tag openvpn-custom:v0.1
```

```
# run container
docker run --cap-add=NET_ADMIN --device /dev/net/tun --net host \
 --name openvpn-server \
 -v /var/log/openvpn:/var/log/openvpn \
 -v /etc/cert:/usr/local/openvpn/server/cert \
 openvpn-custom:v0.1
```
