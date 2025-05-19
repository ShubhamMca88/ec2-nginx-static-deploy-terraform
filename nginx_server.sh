#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# -------------------------
# Configuration Variables
# -------------------------
APP_NAME="tws-portfolio"
APP_DIR="/var/www/${APP_NAME}"
REPO_URL="https://github.com/ShubhamMca88/tws-portfolio.git"
BRANCH="main"
NGINX_CONF="/etc/nginx/conf.d/${APP_NAME}.conf"

# -------------------------
# System Update & Packages
# -------------------------
echo "Updating system packages..."
sudo apt update -y
sudo apt-get update -y

echo "Installing required packages..."
sudo apt-get install -y nginx git ufw

# -------------------------
# Firewall Configuration
# -------------------------
echo "Configuring firewall..."
sudo ufw allow 'Nginx Full'
sudo ufw --force enable

# -------------------------
# Nginx Setup
# -------------------------
echo "Setting up Nginx..."
sudo systemctl enable nginx
sudo systemctl start nginx

# -------------------------
# Application Setup
# -------------------------
echo "Setting up application directory..."
sudo mkdir -p ${APP_DIR}
sudo chown -R $USER:$USER ${APP_DIR}

if [ -d "${APP_DIR}/.git" ]; then
    echo "Repository already cloned. Pulling latest changes..."
    cd ${APP_DIR}
    git pull origin ${BRANCH}
else
    echo "Cloning repository into ${APP_DIR}..."
    sudo rm -rf ${APP_DIR}/*
    git clone -b ${BRANCH} ${REPO_URL} ${APP_DIR}
fi

# Set proper permissions
sudo chown -R www-data:www-data ${APP_DIR}
sudo chmod -R 755 ${APP_DIR}

# -------------------------
# Configure Nginx for Site
# -------------------------
echo "Configuring Nginx..."
sudo tee ${NGINX_CONF} > /dev/null <<EOL
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;

    root ${APP_DIR};
    index index.html index.htm;

    # Logging
    access_log /var/log/nginx/${APP_NAME}_access.log;
    error_log /var/log/nginx/${APP_NAME}_error.log;

    location / {
        try_files \$uri \$uri/ =404;
    }

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-XSS-Protection "1; mode=block";
    add_header X-Content-Type-Options "nosniff";
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
}
EOL

# Test Nginx configuration and restart
echo "Testing Nginx configuration..."
sudo nginx -t

echo "Reloading Nginx..."
sudo systemctl reload nginx

# -------------------------
# Optional: Auto Deployment Script
# -------------------------
echo "Setting up update script..."
UPDATE_SCRIPT="/home/$USER/update_website.sh"

cat << EOF > $UPDATE_SCRIPT
#!/bin/bash
set -e
cd ${APP_DIR}
git pull origin ${BRANCH}
sudo chown -R www-data:www-data ${APP_DIR}
sudo chmod -R 755 ${APP_DIR}
sudo systemctl reload nginx
EOF

chmod +x $UPDATE_SCRIPT

# -------------------------
# Completion Message
# -------------------------
echo "Deployment completed successfully!"
echo "Your website should now be accessible at: http://$(curl -s ifconfig.me)"
echo "To update manually: $UPDATE_SCRIPT"
