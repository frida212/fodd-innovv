# F&B Innovation Platform - Deployment Guide

## 🚀 Quick Deployment

### Option 1: Docker Deployment (Recommended)

1. **Prerequisites**
   - Docker Desktop installed
   - 8GB+ RAM available
   - Ports 80, 3000, 5000, 27017, 6379 available

2. **Deploy with one command**
   ```bash
   # Windows
   deploy.bat
   
   # Linux/Mac
   ./deploy.sh
   ```

3. **Access the application**
   - Frontend: http://localhost
   - API: http://localhost/api
   - Direct Frontend: http://localhost:3000
   - Direct API: http://localhost:5000

### Option 2: Manual Development Setup

1. **Install dependencies**
   ```bash
   # Backend
   npm install
   
   # Frontend
   cd frontend && npm install
   
   # Mobile (optional)
   cd ../mobile && npm install
   ```

2. **Start MongoDB and Redis**
   ```bash
   # MongoDB
   docker run -d -p 27017:27017 --name mongodb mongo:latest
   
   # Redis
   docker run -d -p 6379:6379 --name redis redis:alpine
   ```

3. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env with your settings
   ```

4. **Start services**
   ```bash
   # Backend (Terminal 1)
   npm run dev
   
   # Frontend (Terminal 2)
   cd frontend && npm start
   
   # Mobile (Terminal 3 - optional)
   cd mobile && npm start
   ```

## 🌐 Production Deployment

### Cloud Deployment Options

#### 1. AWS Deployment
```bash
# Using AWS ECS with Docker
aws ecs create-cluster --cluster-name fnb-platform
aws ecs register-task-definition --cli-input-json file://aws-task-definition.json
aws ecs create-service --cluster fnb-platform --service-name fnb-service
```

#### 2. Google Cloud Platform
```bash
# Using Google Cloud Run
gcloud run deploy fnb-backend --source . --platform managed
gcloud run deploy fnb-frontend --source ./frontend --platform managed
```

#### 3. Digital Ocean App Platform
```yaml
# app.yaml
name: fnb-innovation-platform
services:
- name: backend
  source_dir: /
  dockerfile_path: Dockerfile.backend
  http_port: 5000
- name: frontend
  source_dir: /frontend
  dockerfile_path: Dockerfile
  http_port: 80
databases:
- name: mongodb
  engine: MONGODB
- name: redis
  engine: REDIS
```

#### 4. Heroku Deployment
```bash
# Backend
heroku create fnb-backend
heroku addons:create mongolab:sandbox
heroku addons:create heroku-redis:hobby-dev
git subtree push --prefix backend heroku main

# Frontend
heroku create fnb-frontend
heroku buildpacks:set mars/create-react-app
git subtree push --prefix frontend heroku main
```

### Environment Configuration

#### Production Environment Variables
```bash
# Backend (.env)
NODE_ENV=production
PORT=5000
MONGODB_URI=mongodb+srv://user:pass@cluster.mongodb.net/fnb-innovation
REDIS_URL=redis://user:pass@redis-host:6379
JWT_SECRET=your-super-secure-jwt-secret-key
FRONTEND_URL=https://your-domain.com

# Email Configuration
EMAIL_HOST=smtp.sendgrid.net
EMAIL_PORT=587
EMAIL_USER=apikey
EMAIL_PASS=your-sendgrid-api-key

# Payment Processing
STRIPE_SECRET_KEY=sk_live_your_stripe_secret_key
STRIPE_PUBLISHABLE_KEY=pk_live_your_stripe_publishable_key

# File Upload
UPLOAD_PATH=./uploads
MAX_FILE_SIZE=5242880

# Security
CORS_ORIGIN=https://your-domain.com
RATE_LIMIT_WINDOW=15
RATE_LIMIT_MAX=100
```

#### Frontend Environment Variables
```bash
# Frontend (.env.production)
REACT_APP_API_URL=https://api.your-domain.com
REACT_APP_SOCKET_URL=https://api.your-domain.com
REACT_APP_STRIPE_PUBLISHABLE_KEY=pk_live_your_stripe_publishable_key
REACT_APP_GOOGLE_ANALYTICS_ID=GA_MEASUREMENT_ID
```

## 🔧 Infrastructure Setup

### Database Setup

#### MongoDB Atlas (Recommended)
1. Create MongoDB Atlas account
2. Create cluster and database
3. Configure network access
4. Get connection string
5. Update MONGODB_URI in environment

#### Self-hosted MongoDB
```bash
# Install MongoDB
sudo apt-get install mongodb-org

# Configure replica set for production
mongod --replSet rs0 --dbpath /data/db

# Initialize replica set
mongo --eval "rs.initiate()"
```

### Redis Setup

#### Redis Cloud (Recommended)
1. Create Redis Cloud account
2. Create database
3. Get connection details
4. Update REDIS_URL in environment

#### Self-hosted Redis
```bash
# Install Redis
sudo apt-get install redis-server

# Configure for production
sudo nano /etc/redis/redis.conf
# Set: bind 127.0.0.1
# Set: requirepass your-secure-password
```

### SSL/HTTPS Setup

#### Using Let's Encrypt
```bash
# Install Certbot
sudo apt-get install certbot

# Get SSL certificate
sudo certbot certonly --standalone -d your-domain.com

# Update nginx configuration
sudo nano /etc/nginx/sites-available/fnb-platform
```

#### Nginx Configuration
```nginx
server {
    listen 443 ssl http2;
    server_name your-domain.com;
    
    ssl_certificate /etc/letsencrypt/live/your-domain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/your-domain.com/privkey.pem;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
    
    location /api/ {
        proxy_pass http://localhost:5000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

## 📊 Monitoring & Logging

### Application Monitoring
```bash
# Install PM2 for process management
npm install -g pm2

# Start backend with PM2
pm2 start backend/server.js --name fnb-backend

# Monitor processes
pm2 monit

# View logs
pm2 logs fnb-backend
```

### Health Checks
```bash
# Backend health check
curl http://localhost:5000/health

# Frontend health check
curl http://localhost:3000

# Database health check
mongo --eval "db.adminCommand('ping')"
```

### Log Management
```bash
# Configure log rotation
sudo nano /etc/logrotate.d/fnb-platform

# Log configuration
/var/log/fnb-platform/*.log {
    daily
    missingok
    rotate 52
    compress
    notifempty
    create 644 www-data www-data
}
```

## 🔒 Security Checklist

### Production Security
- [ ] Enable HTTPS/SSL
- [ ] Configure CORS properly
- [ ] Set secure JWT secret
- [ ] Enable rate limiting
- [ ] Configure firewall rules
- [ ] Set up database authentication
- [ ] Enable Redis authentication
- [ ] Configure secure headers
- [ ] Set up monitoring alerts
- [ ] Regular security updates

### Environment Security
```bash
# Secure file permissions
chmod 600 .env
chmod 600 ssl/*

# Configure firewall
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable
```

## 📈 Performance Optimization

### Database Optimization
```javascript
// MongoDB indexes
db.orders.createIndex({ restaurant: 1, status: 1 })
db.orders.createIndex({ customer: 1 })
db.menuitems.createIndex({ restaurant: 1, category: 1 })
db.inventory.createIndex({ restaurant: 1, 'alerts.lowStock': 1 })
```

### Caching Strategy
```javascript
// Redis caching
const redis = require('redis');
const client = redis.createClient(process.env.REDIS_URL);

// Cache menu items
app.get('/api/menu', async (req, res) => {
  const cacheKey = `menu:${req.query.restaurant}`;
  const cached = await client.get(cacheKey);
  
  if (cached) {
    return res.json(JSON.parse(cached));
  }
  
  const menuItems = await MenuItem.find(query);
  await client.setex(cacheKey, 300, JSON.stringify(menuItems));
  res.json(menuItems);
});
```

### CDN Configuration
```bash
# Configure CloudFlare or AWS CloudFront
# Cache static assets: *.js, *.css, *.png, *.jpg
# Set cache headers for API responses
```

## 🚨 Troubleshooting

### Common Issues

#### Port Already in Use
```bash
# Find process using port
lsof -i :5000
netstat -tulpn | grep :5000

# Kill process
kill -9 <PID>
```

#### Database Connection Issues
```bash
# Check MongoDB status
sudo systemctl status mongod

# Check connection
mongo --eval "db.adminCommand('ping')"

# View MongoDB logs
sudo tail -f /var/log/mongodb/mongod.log
```

#### Memory Issues
```bash
# Check memory usage
free -h
docker stats

# Increase swap space
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

### Log Analysis
```bash
# Backend logs
docker-compose logs -f backend

# Frontend logs
docker-compose logs -f frontend

# Database logs
docker-compose logs -f mongodb

# System logs
journalctl -u fnb-platform -f
```

## 📞 Support

For deployment support:
- Check the troubleshooting section
- Review application logs
- Verify environment configuration
- Test database connectivity
- Confirm port availability

## 🔄 Updates & Maintenance

### Regular Updates
```bash
# Update application
git pull origin main
docker-compose build --no-cache
docker-compose up -d

# Update dependencies
npm update
cd frontend && npm update
```

### Backup Strategy
```bash
# Database backup
mongodump --uri="mongodb://localhost:27017/fnb-innovation" --out=/backup/$(date +%Y%m%d)

# Application backup
tar -czf fnb-backup-$(date +%Y%m%d).tar.gz /path/to/fnb-innovation
```

---

🎉 **Your F&B Innovation Platform is now ready for production!**