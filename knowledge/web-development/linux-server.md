<!-- ultimo aggiornamento: 2026-03-21 -->

# Linux Server Hosting

## Overview

Notes and configurations for managing Linux servers for web application hosting. Covers setting up different services, troubleshooting common issues, and optimizing server performance.

## Setup

### NGINX

#### What is Nginx?

**Nginx** (pronounced "engine-x") is a powerful, open-source web server that can also be used as a reverse proxy, load balancer, mail proxy, and HTTP cache. Primary uses:
- **Web Server:** serving static files (HTML, CSS, JS, images)
- **Reverse Proxy:** forwarding requests to backend servers
- **Load Balancer:** distributing traffic across multiple servers
- **API Gateway:** managing API requests, authentication, rate limiting

Nginx operates with an event-driven, asynchronous, non-blocking architecture, handling thousands of concurrent connections with minimal overhead.

#### Installation

Connect to remote server:
```bash
ssh [user]@[remote server ip]
sudo apt update
sudo apt install nginx
systemctl status nginx
```

#### Configuration File

Located at `/etc/nginx/sites-available/[project name]`:
```bash
cd /etc/nginx
nano sites-available/[project name]
```

**Web Server Hosting Setup:**
```nginx
server {
    listen 443 ssl http2;
    server_name example.com www.example.com;

    root /path/to/frontend/dist;
    index index.html;

    ssl_certificate /path/to/fullchain.pem;
    ssl_certificate_key /path/to/privkey.pem;
    include /path/to/options-ssl-nginx.conf;
    ssl_dhparam /path/to/ssl-dhparams.pem;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

**API Gateway Setup:**
```nginx
location /api/ {
    proxy_pass http://localhost:3000/;
    proxy_http_version 1.1;

    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_cache_bypass $http_upgrade;
}
```

**HTTP to HTTPS redirect:**
```nginx
server {
    listen 80;
    server_name example.com www.example.com;
    return 301 https://$host$request_uri;
}
```

#### Activate Configuration

```bash
ln -s /etc/nginx/sites-available/[project name] /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
sudo systemctl status nginx
```

## Workflow

### Deploy React Frontend

1. Build the React project and get a tar.gz archive
2. Copy archive to server: `scp [archive].tar.gz [user]@[ip]`
3. SSH into server, extract in `/srv/[project]/`
4. Configure NGINX to serve the `dist` directory

### Deploy ExpressJS Backend

1. Build the ExpressJS project and get a tar.gz archive
2. Copy archive to server: `scp [archive].tar.gz [user]@[ip]`
3. SSH into server, extract in `/srv/[project]/`
4. Install PM2: `npm install pm2@latest -g`
5. Start server: `pm2 start dist/server.js --name [project name]`
6. Update env: `pm2 restart [project name] --update-env`
7. Check status: `pm2 status` and `pm2 logs`
8. Configure NGINX API gateway

### PM2 — Process Manager

[PM2 Documentation](https://pm2.keymetrics.io/docs/usage/quick-start/)

PM2 is a production process manager for Node.js that:
- Keeps applications alive forever
- Reloads without downtime
- Distributes load across CPU cores

## Errori comuni

### Nginx Service Not Running
```bash
sudo systemctl start nginx
sudo systemctl enable nginx
sudo journalctl -xe
```

### "Connection Refused"
- Check firewall: `sudo ufw allow 'Nginx Full' && sudo ufw reload`
- Check cloud provider security groups
- Verify NGINX listening on correct ports

### "403 Forbidden"
```bash
sudo chmod -R 755 /var/www/html
sudo chown -R www-data:www-data /var/www/html
```

### Config syntax errors
```bash
sudo nginx -t
```

### Port Already in Use
```bash
sudo netstat -tulpn | grep :80
sudo netstat -tulpn | grep :443
```

### General Tips
- Always check error logs: `sudo tail -f /var/log/nginx/error.log`
- Always restart after config changes: `sudo systemctl restart nginx`
