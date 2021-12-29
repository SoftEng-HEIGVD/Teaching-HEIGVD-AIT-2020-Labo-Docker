# Base image is the Official HAProxy
FROM haproxy:2.2

# Author
LABEL Rui Filipe Lopes Gouveia <rui.lopesgouveia@heig-vd.ch>

# Install some tools
# TODO: [HB] Update to install required tool to install NodeJS
RUN apt-get update && apt-get -y install wget curl vim iputils-ping rsyslog

# Download and install S6 overlay
RUN curl -sSLo /tmp/s6.tar.gz https://github.com/just-containers/s6-overlay/releases/download/v2.1.0.2/s6-overlay-amd64.tar.gz \
  && tar xzf /tmp/s6.tar.gz -C / \
  && rm -f /tmp/s6.tar.gz

# Install serf (for decentralized cluster membership: https://www.serf.io/)
RUN mkdir /opt/bin \
    && curl -sSLo /tmp/serf.gz https://releases.hashicorp.com/serf/0.8.2/serf_0.8.2_linux_amd64.zip \
    && gunzip -c /tmp/serf.gz > /opt/bin/serf \
    && chmod 755 /opt/bin/serf \
    && rm -f /tmp/serf.gz

# TODO: [HB] Install NodeJS

# TODO: [HB] Install Handlebars

# Copy the S6 service and make the run script executable
COPY services/ha /etc/services.d/ha
RUN chmod +x /etc/services.d/ha/run

# Copy the serf service and make the run script executable
COPY services/serf /etc/services.d/serf
RUN chmod +x /etc/services.d/serf/run

# TODO: [Serf] Copy events handler scripts
RUN mkdir /serf-handlers
COPY scripts/member-leave.sh /serf-handlers
COPY scripts/member-join.sh /serf-handlers
RUN chmod +x /serf-handlers/member-join.sh
RUN chmod +x /serf-handlers/member-leave.sh

# Copy the haproxy and syslog config
COPY config/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY config/rsyslogd.cfg /etc/rsyslog.d/49-haproxy.conf

# TODO: [HB] Copy the haproxy configuration template

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# TODO: [CFG] Create the nodes folder

# Expose the ports for Serf
EXPOSE 7946 7373

# Expose the HA proxy ports
EXPOSE 80 1936

# Define an environment variable
ENV ROLE balancer

# This will start S6 as our main process in our container
ENTRYPOINT ["/init"]
