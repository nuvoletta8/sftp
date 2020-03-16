#!/bin/bash
set -e

useradd $SFTP_USER 
mkdir -p /home/$SFTP_USER/.ssh
touch /home/$SFTP_USER/.ssh/authorized_keys
chmod 755 /home/$SFTP_USER

if [  "$SFTP_PASSWORD" == 'thispasswordneedstobechanged' ]; then
  echo "[error] Please change the default password."
  exit 127
fi

if [ -n "$SFTP_PASSWORD" ]; then
    echo "$SFTP_USER:$SFTP_PASSWORD" | chpasswd $chpasswdOptions
else
    usermod -p "*" $SFTP_USER # disabled password
fi

# # TODO: ssh key authentication
# if [ -n "$SFTP_PUBLICKEY" ]; then
#     mkdir -p /home/$SFTP_USER/.ssh
#     echo "$SFTP_PUBLICKEY" > /home/$SFTP_USER/.ssh/authorized_keys
#     chown $SFTP_USER /home/$SFTP_USER/.ssh
#     chmod 700 /home/$SFTP_USER/.ssh/authorized_keys
#     chmod 600 /home/$SFTP_USER/.ssh/
# fi

mkdir -p /home/$SFTP_USER/upload
chmod 755 /etc/shadow
chmod 777 /etc/passwd
# chmod 700 /home/${SFTP_USER}/.ssh/authorized_keys
# chmod 600 /home/${SFTP_USER}/.ssh/
#chown -R ${SFTP_USER}:${SFTP_USER} /home/${SFTP_USER}/.ssh
chown -R ${SFTP_USER}:${SFTP_USER} /home/${SFTP_USER}

