#!/bin/bash

# Guides:
# - https://github.com/OpenVPN/openvpn
# - https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage

OPENVPN_VERSION=2.6.12
CONFIG_DIR=/usr/local/openvpn
SERVER_DIR=${CONFIG_DIR}/server
CLIENT_DIR=${CONFIG_DIR}/client
CERT_DIR=${SERVER_DIR}/cert

# requeriments
apt update
apt install -y wget gcc pkg-config make \
 libnl-genl-3-dev libcap-ng-dev libssl-dev \
 liblzo2-dev liblz4-dev \
 libpam0g-dev

# download openvpn version $OPENVPN_VERSION
cd /usr/src
wget -O openvpn-${OPENVPN_VERSION}.tar.gz \
 https://github.com/OpenVPN/openvpn/releases/download/v${OPENVPN_VERSION}/openvpn-${OPENVPN_VERSION}.tar.gz
tar -xf openvpn-${OPENVPN_VERSION}.tar.gz
cd openvpn-${OPENVPN_VERSION}


# compile/install
mkdir -p $SERVER_DIR $CERT_DIR
./configure --prefix=$CONFIG_DIR --sysconfdir=$SERVER_DIR
make -j$(nproc)
make install #DESTDIR=/usr/src/openvpn


echo 'IyBiYXNpYyBzZXR1cAptb2RlIHNlcnZlcgojbG9jYWwgMjgwNDo6CiNsb2NhbCAxOTIuMTY4Li4u
CnBvcnQgMTE5NApwcm90byB1ZHA2CmRldiB0dW4KCiMgcHJvY2VzcyBydW4KdXNlciBub2JvZHkK
Z3JvdXAgbm9ncm91cAoKIyBsb2cKI2xvZy1hcHBlbmQgL3Zhci9sb2cvb3BlbnZwbi5sb2cKdmVy
YiA3CgojIGNlcnRpZmljYXRlCmNhIGNlcnQvY2EuY3J0CiNjZXJ0LmNydApjZXJ0IGNlcnQvc2Vy
dmVyLmNydAojIFRoaXMgZmlsZSBzaG91bGQgYmUga2VwdCBzZWNyZXQKa2V5IGNlcnQvc2VydmVy
LmtleQoKZGggbm9uZQoKIyBuZXR3b3JrIHByaXZhdGUgVlBOCnRvcG9sb2d5IHN1Ym5ldApzZXJ2
ZXIgMTAuOC4wLjAgMjU1LjI1NS4yNTUuMApzZXJ2ZXItaXB2NiBmZDQyOjQyOjQyOjQyOjovMTEy
CgojIGFkZHJlc3MgcmVsZWFzZSBsb2cKaWZjb25maWctcG9vbC1wZXJzaXN0IC92YXIvbG9nL29w
ZW52cG4vcmVsZWFzZXMudHh0CgojIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiMgQ2xpZW50IGFm
ZmVjdApwZXJzaXN0LWtleQpwZXJzaXN0LXR1bgpwdXNoIHR1bi1pcHY2CgojIEF1dGggd2l0aCB1
c2VyIGFuZCBwYXNzd29yZApzY3JpcHQtc2VjdXJpdHkgMgphdXRoLXVzZXItcGFzcy12ZXJpZnkg
Y2hlY2twYXNzd2Quc2ggdmlhLWZpbGUKdmVyaWZ5LWNsaWVudC1jZXJ0IG9wdGlvbmFsCiN1c2Vy
bmFtZS1hcy1jb21tb24tbmFtZQoKI2NsaWVudC1jb25maWctZGlyIC9ldGMvb3BlbnZwbi9jY2QK
I2NjZC1leGNsdXNpdmUKCiMjIHNldCByb3V0ZQpwdXNoICJyb3V0ZSAxOTIuMTY4LjAuMCAyNTUu
MjU1LjAuMCIKIyMgc2V0IEROUyBsb2NhbApwdXNoICJkaGNwLW9wdGlvbiBETlMgMS4xLjEuMSIK' |base64 -d > $SERVER_DIR/server.conf

# TODO: Check permissions
# TODO: Cipher passwords, change to binary maybe
echo 'IyEvYmluL2Jhc2gKVVNFUj0kMQpQQVNTPSQyCgplY2hvICIkVVNFUjokUEFTUyIgPiAvdG1wL3Ry
eS5vdnBuCgojIENhbWluaG8gcGFyYSBvIGFycXVpdm8gZGUgc2VuaGFzClBBU1NGSUxFPSIvZXRj
L29wZW52cG4vcGFzc3dkLmZpbGUiCkNPUlJFQ1RfUEFTUz0kKGdyZXAgIl4kVVNFUjoiICRQQVNT
RklMRSB8IGN1dCAtZCAiOiIgLWYgMikKCmlmIFsgIiRDT1JSRUNUX1BBU1MiID09ICIkUEFTUyIg
XTsgdGhlbgogIGVjaG8gIk9LIiA+PiAvdG1wL3RyeS5vdnBuCiAgZXhpdCAwCmVsc2UKICBlY2hv
ICJGQUlMIiA+PiAvdG1wL3RyeS5vdnBuCiAgZXhpdCAxCmZpCg==' |base64 -d > $SERVER_DIR/checkpasswd.sh
chmod +x $SERVER_DIR/checkpasswd.sh

echo 'dXNlcjoxMjMKdXNlcjE6MTIzCg==' |base64 -d > $SERVER_DIR/passwd.file

# Manage certificates
apt install -y easy-rsa

# create certs
#...
chmod 640 ${SERVER_DIR}/cert/*.key
#...


sysctl -w net.ipv4.conf.all.forwarding=1 net.ipv6.conf.all.forwarding=1

# running
#/usr/local/openvpn/sbin/openvpn --cd $SERVER_DIR --config server.conf



# TO CLIENT
mkdir -p ${CLIENT_DIR}/ccd ${CLIENT_DIR}/cert




