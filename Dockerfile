FROM alpine:3.7

# User and Password creation
# Edit those variables for creating the User and the password
ENV SFTP_USER 'sftp'
ENV SFTP_PASSWORD 'thispasswordneedstobechanged'
# TODO: If the password is empty the password authentication will be disabled and an SSH key
# will be loaded from the environment variable SFTP_PUBLICKEY
# ENV SFTP_PUBLICKEY 'ssh-rsa...'



# Installing sftp and creating configuration directories
RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache bash shadow@community openssh openssh-sftp-server && \
    mkdir -p /var/run/sshd && \
    mkdir -p /var/run/sftp && \
    rm -f /etc/ssh/ssh_host_*key*


COPY sftp-container/init.sh /
RUN chmod +x init.sh && ./init.sh

COPY sftp-container/sshd_config /etc/ssh/sshd_config

# Copy certs files
COPY keys/ssh_host_ed25519_key /tmp/ssh_host_ed25519_key
COPY keys/ssh_host_rsa_key /tmp/ssh_host_rsa_key
RUN chmod 600 /tmp/ssh_host*
#RUN chown sftp:sftp /tmp/ssh_host*
RUN chgrp -R 0 /tmp/ssh_host* && \
    chmod -R g=u /tmp/ssh_host*

EXPOSE 2222

USER sftp


COPY change-id.sh /tmp/

CMD ["/bin/bash", "/tmp/change-id.sh"]
