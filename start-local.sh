#!/bin/bash

# Stock Tracker Spring Boot - Local Development Startup Script
# This script starts both backend and frontend servers

echo "🚀 Starting Stock Tracker Application..."
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check Java version
echo "📋 Checking prerequisites..."
if command -v java &> /dev/null; then
    JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
    if [ "$JAVA_VERSION" -ge 17 ]; then
        echo -e "${GREEN}✅ Java $JAVA_VERSION installed${NC}"
    else
        echo -e "${RED}❌ Java 17+ required. Current: Java $JAVA_VERSION${NC}"
        echo "   Install Java 17: brew install openjdk@17"
        exit 1
    fi
else
    echo -e "${RED}❌ Java not found${NC}"
    echo "   Install: brew install openjdk@17"
    exit 1
fi

# Check Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    echo -e "${GREEN}✅ Node.js $NODE_VERSION installed${NC}"
else
    echo -e "${RED}❌ Node.js not found${NC}"
    echo "   Install: brew install node"
    exit 1
fi

echo ""
echo "🏗️  Starting backend (Spring Boot)..."

# Start backend in background
cd backend
chmod +x mvnw
./mvnw spring-boot:run > ../backend.log 2>&1 &
BACKEND_PID=$!
cd ..

echo -e "${YELLOW}⏳ Waiting for backend to start...${NC}"
sleep 10

# Check if backend is running
if curl -s http://localhost:8080/actuator/health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Backend running on http://localhost:8080${NC}"
elif curl -s http://localhost:8080 > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Backend running on http://localhost:8080${NC}"
else
    echo -e "${YELLOW}⏳ Backend still starting... (check backend.log for details)${NC}"
fi

echo ""
echo "🎨 Starting frontend (React)..."
echo ""

# Start frontend
cd frontend

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi

# Start frontend (this will keep the terminal open)
npm start

# Cleanup function
cleanup() {
    echo ""
    echo "🛑 Shutting down..."
    kill $BACKEND_PID 2>/dev/null
    echo "✅ Stopped backend (PID: $BACKEND_PID)"
    exit 0
}

# Trap Ctrl+C
trap cleanup INT TERM
