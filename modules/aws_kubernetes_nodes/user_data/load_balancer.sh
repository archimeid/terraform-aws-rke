sudo yum install yum-utils

cat <<'EOF' | sudo tee /etc/yum.repos.d/nginx.repo
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/amzn2/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/amzn2/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
EOF

sudo rmp --import https://nginx.org/keys/nginx_signing.key
sudo yum -y install nginx

# TODO - Add Nginx Config to load balance to kubeapi and ingress
# Kubeapi : Control Plane Nodes
# Nginx Ingress : Worker Nodes

sudo systemctl start nginx