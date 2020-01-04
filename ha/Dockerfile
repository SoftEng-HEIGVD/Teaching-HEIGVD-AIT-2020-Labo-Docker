# Base image is the Official HAProxy
FROM haproxy:1.5

# TODO: [GEN] Replace with your name and email
MAINTAINER Francine Youndzo <francine.youndzokengne@heig-vd.ch>

# Install some tools
# TODO: [HB] Update to install required tool to install NodeJS
RUN apt-get update && apt-get -y install wget curl vim iputils-ping rsyslog

# Download and install S6 overlay
RUN curl -sSLo /tmp/s6.tar.gz https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz && tar xzf /tmp/s6.tar.gz -C / && rm -f /tmp/s6.tar.gz

# TODO: [Serf] Install
# Install serf (for decentralized cluster membership: https://www.serf.io/)
RUN mkdir /opt/bin \
    && curl -sSLo /tmp/serf.gz https://releases.hashicorp.com/serf/0.7.0/serf_0.7.0_linux_amd64.zip \
    && gunzip -c /tmp/serf.gz > /opt/bin/serf \
    && chmod 755 /opt/bin/serf \
    && rm -f /tmp/serf.gz

# TODO: [HB] Install NodeJS

# TODO: [HB] Install Handlebars

# TODO: [S6] Replace the two following instructions
# Copy the S6 service and make the run script executable
COPY services/ha /etc/services.d/ha
RUN chmod +x /etc/services.d/ha/run
# Copy all the scripts and make them executable
COPY scripts/ /scripts/
RUN chmod +x /scripts/*.sh

# TODO: [Serf] Add Serf S6 setup
# Copy the Serf agent run script and make it executable
COPY services/serf /etc/services.d/serf
RUN chmod +x /etc/services.d/serf/run

# TODO: [Serf] Copy events handler scripts

# Copy the haproxy and syslog config
COPY config/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY config/rsyslogd.cfg /etc/rsyslog.d/49-haproxy.conf

# TODO: [HB] Copy the haproxy configuration template

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# TODO: [CFG] Create the nodes folder

# TODO: [Serf] Expose ports
# Expose the ports for Serf
EXPOSE 7946 7373

# Expose the HA proxy ports
EXPOSE 80 1936

# Define an environment variable
ENV ROLE balancer

# TODO: [S6] Replace the following instruction
# This will start S6 as our main process in our container
ENTRYPOINT ["/init"]

# Command executed when the container starts
CMD [ "/scripts/run.sh" ]
