#!/bin/bash

# F&B Innovation Platform Deployment Script
echo "🚀 Starting F&B Innovation Platform deployment..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p uploads
mkdir -p ssl
mkdir -p logs

# Set permissions
chmod 755 uploads
chmod 755 logs

# Copy environment file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating environment file..."
    cp .env.example .env
    echo "⚠️  Please edit .env file with your configuration before running the application"
fi

# Build and start services
echo "🔨 Building and starting services..."
docker-compose down --remove-orphans
docker-compose build --no-cache
docker-compose up -d

# Wait for services to be ready
echo "⏳ Waiting for services to start..."
sleep 30

# Check service health
echo "🔍 Checking service health..."

# Check MongoDB
if docker-compose exec -T mongodb mongosh --eval "db.adminCommand('ping')" > /dev/null 2>&1; then
    echo "✅ MongoDB is running"
else
    echo "❌ MongoDB failed to start"
fi

# Check Redis
if docker-compose exec -T redis redis-cli ping > /dev/null 2>&1; then
    echo "✅ Redis is running"
else
    echo "❌ Redis failed to start"
fi

# Check Backend
if curl -f http://localhost:5000/health > /dev/null 2>&1; then
    echo "✅ Backend API is running"
else
    echo "❌ Backend API failed to start"
fi

# Check Frontend
if curl -f http://localhost:3000 > /dev/null 2>&1; then
    echo "✅ Frontend is running"
else
    echo "❌ Frontend failed to start"
fi

# Check Nginx
if curl -f http://localhost > /dev/null 2>&1; then
    echo "✅ Nginx proxy is running"
else
    echo "❌ Nginx proxy failed to start"
fi

echo ""
echo "🎉 Deployment completed!"
echo ""
echo "📱 Application URLs:"
echo "   Frontend: http://localhost"
echo "   API: http://localhost/api"
echo "   Direct Frontend: http://localhost:3000"
echo "   Direct API: http://localhost:5000"
echo ""
echo "🔧 Management Commands:"
echo "   View logs: docker-compose logs -f [service-name]"
echo "   Stop services: docker-compose down"
echo "   Restart services: docker-compose restart"
echo "   Update services: docker-compose pull && docker-compose up -d"
echo ""
echo "📊 Database Access:"
echo "   MongoDB: mongodb://admin:fnb2024secure@localhost:27017/fnb-innovation"
echo "   Redis: redis://localhost:6379"
echo ""

# Show running containers
echo "🐳 Running containers:"
docker-compose ps