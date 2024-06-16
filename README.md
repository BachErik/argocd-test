# Install ArgoCD on k3s
```bash
wget -O - https://raw.githubusercontent.com/BachErik/argocd-test/master/install.sh | bash
```
get admin password:
```bash
kubectl --namespace argocd get secret argocd-initial-admin-secret -o json | jq -r '.data.password' | base64 -d
```

Now you are ready to go!
