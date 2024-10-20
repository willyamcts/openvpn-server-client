FROM debian:bookworm-slim
WORKDIR /usr/local/openvpn/server
COPY install.sh /tmp
RUN cd /tmp && \
 chmod +x install.sh && ./install.sh
# Testing
#COPY cert /usr/local/openvpn/server/cert

ENTRYPOINT ["/usr/local/openvpn/sbin/openvpn", "--config", "server.conf"]
# Testing
#ENTRYPOINT ["/bin/bash"]
