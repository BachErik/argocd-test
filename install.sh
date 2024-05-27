#!/bin/bash

# Paketquellen aktualisieren und System upgraden
apt update
apt upgrade -y
apt install git wget gpg jq -y

# k9s installieren
wget https://github.com/derailed/k9s/releases/download/v0.32.4/k9s_Linux_amd64.tar.gz
tar xvf k9s_Linux_amd64.tar.gz
chmod +x k9s
mv k9s /bin/
rm LICENSE README.md k9s_Linux_amd64.tar.gz

# k3s installieren
curl -sfL https://get.k3s.io | sh -

# Warte auf das Hochfahren von k3s
while ! systemctl is-active --quiet k3s; do
    echo "Warten auf den Start von k3s..."
    sleep 10
done

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

rm get_helm.sh

mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $(id -u):$(id -g) ~/.kube/config

UBUNTU_CODENAME=jammy
wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list
sudo apt update && sudo apt install ansible -y

wget https://raw.githubusercontent.com/BachErik/argocd-test/master/ansible/install_argocd_on_k3s.yaml
ansible-playbook install_argocd_on_k3s.yaml
rm install_argocd_on_k3s.yaml
