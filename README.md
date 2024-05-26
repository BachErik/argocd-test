# Install ArgoCD on k3s
```bash
UBUNTU_CODENAME=jammy
wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/ansible.list
sudo apt update && sudo apt install ansible -y
wget https://raw.githubusercontent.com/BachErik/argocd-test/master/ansible/install_argocd_on_k3s.yaml
ansible-playbook install_argocd_on_k3s.yaml
rm install_argocd_on_k3s.yaml
```
