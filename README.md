# Stock Tracker - Spring Boot + React

A Spring Boot backend with React frontend implementation of the NSE Stock Performance Tracker.

## Project Structure

```
Stock-Tracker-Spring/
├── backend/          # Spring Boot application
│   ├── src/
│   └── pom.xml
└── frontend/         # React application
    ├── src/
    └── package.json
```

## Backend (Spring Boot)

### Prerequisites
- Java 17 or higher
- Maven

### Running the Backend
```bash
cd backend
./mvnw spring-boot:run
```

The backend will start on `http://localhost:8080`

## Frontend (React)

### Prerequisites
- Node.js 16 or higher
- npm or yarn

### Running the Frontend
```bash
cd frontend
npm install
npm start
```

The frontend will start on `http://localhost:3000`

## Features

- Stock performance tracking
- File upload for custom stock lists
- Real-time data fetching from Yahoo Finance
- Performance metrics (1M, 2M, 3M)

## Related Project

This is an alternative implementation of the Streamlit-based NSE Stock Performance Tracker:
- Main project (Streamlit): [stock-performance-tracker](https://github.com/orcakrishna/stock-performance-tracker)

## API Endpoints

- `GET /api/stocks/performance?symbols=RELIANCE.NS,TCS.NS` - Get stock performance data
- `POST /api/stocks/upload` - Upload stock list file

## License

MIT
