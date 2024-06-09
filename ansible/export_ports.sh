apt update
apt upgrade
apt install ufw -y
ufw allow 22/tcp
ufw allow 6443/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 10250/tcp
ufw deny 10251/tcp
ufw deny 10252/tcp
ufw allow 8285/udp
ufw allow 8472/udp
ufw enable
y