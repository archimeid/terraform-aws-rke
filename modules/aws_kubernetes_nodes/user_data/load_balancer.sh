echo "Install yum-utils..."
sudo yum install yum-utils

echo "Add nginx repositories..."
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

echo "Install nginx..."
sudo rmp --import https://nginx.org/keys/nginx_signing.key
sudo yum -y install nginx

sudo yum -y update

# TODO - Add Nginx Config to load balance to kubeapi and ingress
# Kubeapi : Control Plane Nodes
# Nginx Ingress : Worker Nodes

echo "Activate Nginx at startup..."
sudo systemctl enable nginx
sudo systemctl stop nginx

echo "Install certbot..."
sudo wget -r --no-parent -A 'epel-release-*.rpm' https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/
sudo rpm -Uvh dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-*.rpm
sudo yum-config-manager --enable epel*
sudo yum repolist all
sudo yum install -y certbot