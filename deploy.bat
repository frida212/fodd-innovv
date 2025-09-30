@echo off
echo 🚀 Starting F&B Innovation Platform deployment...

REM Check if Docker is installed
docker --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker is not installed. Please install Docker Desktop first.
    pause
    exit /b 1
)

docker-compose --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Docker Compose is not installed. Please install Docker Desktop first.
    pause
    exit /b 1
)

REM Create necessary directories
echo 📁 Creating directories...
if not exist "uploads" mkdir uploads
if not exist "ssl" mkdir ssl
if not exist "logs" mkdir logs

REM Copy environment file if it doesn't exist
if not exist ".env" (
    echo 📝 Creating environment file...
    copy ".env.example" ".env"
    echo ⚠️  Please edit .env file with your configuration before running the application
)

REM Build and start services
echo 🔨 Building and starting services...
docker-compose down --remove-orphans
docker-compose build --no-cache
docker-compose up -d

REM Wait for services to be ready
echo ⏳ Waiting for services to start...
timeout /t 30 /nobreak >nul

echo 🔍 Checking service health...

REM Check if services are running
docker-compose ps

echo.
echo 🎉 Deployment completed!
echo.
echo 📱 Application URLs:
echo    Frontend: http://localhost
echo    API: http://localhost/api
echo    Direct Frontend: http://localhost:3000
echo    Direct API: http://localhost:5000
echo.
echo 🔧 Management Commands:
echo    View logs: docker-compose logs -f [service-name]
echo    Stop services: docker-compose down
echo    Restart services: docker-compose restart
echo    Update services: docker-compose pull ^&^& docker-compose up -d
echo.
echo 📊 Database Access:
echo    MongoDB: mongodb://admin:fnb2024secure@localhost:27017/fnb-innovation
echo    Redis: redis://localhost:6379
echo.

pause