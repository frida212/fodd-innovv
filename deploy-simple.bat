@echo off
echo 🚀 Deploying F&B Innovation Platform to Vercel (Fixed Version)...

REM Check if Vercel CLI is installed
vercel --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Vercel CLI not found. Installing...
    npm install -g vercel
)

echo 📦 Installing root dependencies...
npm install

echo 🔨 Installing frontend dependencies...
cd frontend
npm install
cd ..

echo 🌐 Deploying to Vercel...
vercel --prod

echo.
echo 🎉 Deployment completed!
echo.
echo 📱 Your F&B Innovation Platform should now be live!
echo.
echo ✅ Features available:
echo    - Interactive Menu System
echo    - Shopping Cart & Checkout  
echo    - Analytics Dashboard
echo    - Order Management
echo    - Mobile Responsive Design
echo.
echo 🔗 Test your deployment:
echo    - Visit your Vercel URL
echo    - Check /api/health endpoint
echo    - Browse the menu and place test orders
echo.

pause