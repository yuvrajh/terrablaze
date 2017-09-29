#!/usr/bin/env bash
set -e

sudo yum install -y httpd
sudo service httpd restart
sudo cat > /var/www/html/index.html << EOF
Welcome
EOF