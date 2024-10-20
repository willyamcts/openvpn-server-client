# OpenVPN Server
OpenVPN server implementation basic and configuration specific by client

# Setup
The requirements are incorporated into scripts, but to follow the guidelines exactly you need to have Docker installed. Guide for Docker instalation [here](https://docs.docker.com/engine/install/), for Debian [here](https://docs.docker.com/engine/install/debian/#install-using-the-repository)

```
apt update
apt install -y logrotate

git clone <this repository>
cp openvpn-server/openvpn.rotate /etc/logrotate.d/

mkdir -p /var/log/openvpn/rotate
```

# Suggestions for improvements 
Suggestions are welcome, open the issue please and select correct tag (improvement, bug, ...)

# Environment
Tested in Debian only 
