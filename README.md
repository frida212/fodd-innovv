# F&B Innovation Platform

A comprehensive Food & Beverage innovation platform designed to optimize restaurant operations and enhance customer experiences through modern technology.

## 🚀 Features

### Customer Experience
- **Digital Menu**: Interactive menu with dietary filters, nutritional info, and real-time availability
- **Smart Ordering**: Multi-channel ordering (dine-in, takeout, delivery) with customizations
- **Real-time Tracking**: Live order status updates and estimated preparation times
- **Feedback System**: Integrated rating and review system for continuous improvement

### Operations Management
- **Order Management**: Real-time order processing with kitchen display system
- **Inventory Control**: Automated stock tracking with low-stock alerts and purchase order generation
- **Staff Mobile App**: Native mobile application for staff to manage orders and inventory
- **Analytics Dashboard**: Comprehensive insights into sales, performance, and customer behavior

### Business Intelligence
- **Revenue Analytics**: Daily, weekly, and monthly revenue tracking with trends
- **Popular Items**: Data-driven menu optimization based on order frequency and ratings
- **Peak Hours Analysis**: Staffing optimization through demand pattern analysis
- **Operational Efficiency**: Preparation time tracking and order accuracy metrics

## 🏗️ Architecture

```
fnb-innovation/
├── backend/           # Node.js/Express API server
│   ├── models/        # MongoDB data models
│   ├── routes/        # API endpoints
│   └── server.js      # Main server file
├── frontend/          # React web application
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   └── services/
│   └── package.json
├── mobile/            # React Native staff app
│   ├── src/
│   │   ├── screens/
│   │   └── context/
│   └── App.js
├── config/            # Configuration files
└── docs/             # Documentation
```

## 🛠️ Technology Stack

### Backend
- **Node.js** with Express.js framework
- **MongoDB** with Mongoose ODM
- **Socket.io** for real-time communication
- **JWT** for authentication
- **Redis** for caching and session management

### Frontend
- **React 18** with modern hooks
- **Material-UI** for component library
- **React Query** for data fetching and caching
- **Recharts** for analytics visualization
- **Socket.io Client** for real-time updates

### Mobile
- **React Native** with Expo
- **React Navigation** for navigation
- **React Native Paper** for UI components
- **Native device features** (camera, notifications)

## 🚀 Quick Start

### Prerequisites
- Node.js (v16 or higher)
- MongoDB (v5.0 or higher)
- Redis (optional, for caching)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd fnb-innovation
   ```

2. **Install backend dependencies**
   ```bash
   npm install
   ```

3. **Install frontend dependencies**
   ```bash
   cd frontend
   npm install
   cd ..
   ```

4. **Install mobile dependencies**
   ```bash
   cd mobile
   npm install
   cd ..
   ```

5. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

6. **Start MongoDB**
   ```bash
   # Using MongoDB service
   sudo systemctl start mongod
   
   # Or using Docker
   docker run -d -p 27017:27017 --name mongodb mongo:latest
   ```

### Running the Application

1. **Start the backend server**
   ```bash
   npm run dev
   ```

2. **Start the frontend (in a new terminal)**
   ```bash
   cd frontend
   npm start
   ```

3. **Start the mobile app (in a new terminal)**
   ```bash
   cd mobile
   npm start
   ```

The applications will be available at:
- Backend API: http://localhost:5000
- Frontend Web App: http://localhost:3000
- Mobile App: Expo DevTools will provide QR code for device testing

## 📊 Key Metrics & KPIs

The platform tracks essential restaurant metrics:

- **Order Volume**: Daily/weekly/monthly order counts
- **Revenue Tracking**: Real-time revenue with trend analysis
- **Average Order Value**: Customer spending patterns
- **Preparation Times**: Kitchen efficiency metrics
- **Customer Satisfaction**: Rating and feedback analysis
- **Inventory Turnover**: Stock movement and waste reduction
- **Peak Hours**: Demand pattern identification

## 🔧 Configuration

### Database Setup
The platform uses MongoDB for data persistence. Key collections:
- `restaurants`: Restaurant information and settings
- `menuitems`: Menu items with pricing and availability
- `orders`: Order management and tracking
- `inventory`: Stock levels and supplier information
- `customers`: Customer profiles and preferences

### Real-time Features
Socket.io enables real-time features:
- Live order updates for kitchen staff
- Customer order tracking
- Inventory alerts
- Staff notifications

## 🚀 Deployment

### Production Deployment
1. Set `NODE_ENV=production` in environment variables
2. Configure production MongoDB URI
3. Set up Redis for session management
4. Configure email service for notifications
5. Set up SSL certificates for HTTPS

### Docker Deployment
```bash
# Build and run with Docker Compose
docker-compose up -d
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 API Documentation

### Core Endpoints

#### Orders
- `POST /api/orders` - Create new order
- `GET /api/orders/restaurant/:id` - Get restaurant orders
- `PATCH /api/orders/:id/status` - Update order status

#### Menu
- `GET /api/menu/restaurant/:id` - Get menu items
- `POST /api/menu` - Add menu item
- `PATCH /api/menu/:id` - Update menu item

#### Analytics
- `GET /api/analytics/dashboard/:id` - Get analytics dashboard
- `GET /api/analytics/efficiency/:id` - Get operational metrics

#### Inventory
- `GET /api/inventory/restaurant/:id` - Get inventory items
- `PATCH /api/inventory/:id/stock` - Update stock levels
- `GET /api/inventory/alerts/:id` - Get low stock alerts

## 📱 Mobile App Features

The staff mobile application provides:
- **Order Management**: View and update order status
- **Inventory Control**: Stock level monitoring and updates
- **Real-time Notifications**: Instant alerts for new orders
- **Analytics View**: Key performance metrics on mobile
- **Offline Support**: Basic functionality without internet

## 🔒 Security Features

- JWT-based authentication
- Input validation and sanitization
- Rate limiting on API endpoints
- CORS configuration
- Environment variable protection
- Secure password hashing

## 📈 Performance Optimization

- Database indexing for fast queries
- Redis caching for frequently accessed data
- Image optimization for menu items
- Lazy loading in frontend components
- Connection pooling for database
- CDN integration for static assets

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Check the documentation in `/docs`
- Review the API examples in `/examples`

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

Built with ❤️ for the F&B industry to drive innovation and operational excellence.