# Stock Tracker Spring Boot - Setup & Deployment Guide

## 📋 Prerequisites Check

**Current System Status:**
- ❌ Java 8 detected (Need Java 17+)
- ❌ Node.js not installed (Need Node.js 16+)

---

## 🔧 Installation Steps

### Step 1: Install Java 17

**Option A: Using Homebrew (Recommended)**
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Java 17
brew install openjdk@17

# Link it
sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk

# Add to PATH (add to ~/.zshrc or ~/.bash_profile)
echo 'export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

# Verify
java -version  # Should show version 17
```

**Option B: Download from Oracle**
1. Visit: https://www.oracle.com/java/technologies/downloads/#java17
2. Download macOS installer
3. Install and verify with `java -version`

### Step 2: Install Node.js

**Option A: Using Homebrew (Recommended)**
```bash
brew install node

# Verify
node --version  # Should show v18+ or v20+
npm --version
```

**Option B: Download from Official Site**
1. Visit: https://nodejs.org/
2. Download LTS version (Long Term Support)
3. Install and verify with `node --version`

---

## 🚀 Running Locally

### Terminal 1: Start Backend (Spring Boot)

```bash
cd /Users/krishnashukla/Desktop/NSE/CascadeProjects/Stock-Tracker-Spring/backend

# Make mvnw executable
chmod +x mvnw

# Run the backend
./mvnw spring-boot:run
```

**Backend will start on:** `http://localhost:8080`

**Test it:**
```bash
curl http://localhost:8080/api/stocks/performance?symbols=RELIANCE.NS,TCS.NS
```

### Terminal 2: Start Frontend (React)

```bash
cd /Users/krishnashukla/Desktop/NSE/CascadeProjects/Stock-Tracker-Spring/frontend

# Install dependencies (first time only)
npm install

# Start development server
npm start
```

**Frontend will start on:** `http://localhost:3000`

**Access the app:** Open browser at `http://localhost:3000`

---

## 🌐 Public Hosting Options

### Option 1: Railway (Easiest - Free Tier Available)

**For Backend:**
1. Sign up at https://railway.app
2. Click "New Project" → "Deploy from GitHub repo"
3. Select your `Stock-Tracker-Spring` repository
4. Railway auto-detects Spring Boot
5. Add environment variables if needed
6. Deploy! You'll get a URL like: `https://your-app.railway.app`

**For Frontend:**
1. Build production version:
   ```bash
   cd frontend
   npm run build
   ```
2. Deploy `build/` folder to Railway or Netlify

**Cost:** Free tier available (500 hours/month)

---

### Option 2: Render (Free Tier Available)

**Backend Deployment:**
```bash
cd /Users/krishnashukla/Desktop/NSE/CascadeProjects/Stock-Tracker-Spring
```

1. Create `render.yaml` in project root:
```yaml
services:
  - type: web
    name: stock-tracker-backend
    env: java
    buildCommand: cd backend && ./mvnw clean install
    startCommand: cd backend && java -jar target/nsepulse-0.0.1-SNAPSHOT.jar
    envVars:
      - key: JAVA_TOOL_OPTIONS
        value: -Xmx512m
```

2. Push to GitHub
3. Go to https://render.com
4. New → Web Service → Connect GitHub repo
5. Render auto-deploys

**Frontend:**
- Deploy to Netlify or Vercel (see below)

**Cost:** Free tier available

---

### Option 3: AWS Elastic Beanstalk (Production Grade)

**Backend:**
```bash
cd backend

# Create JAR file
./mvnw clean package

# Install AWS CLI and EB CLI
brew install awscli
pip3 install awsebcli

# Initialize and deploy
eb init
eb create stock-tracker-env
eb deploy
```

**Frontend:**
- Deploy to S3 + CloudFront or Amplify

**Cost:** ~$10-30/month (pay as you go)

---

### Option 4: Heroku (Was Free, Now Paid)

**Backend:**
```bash
cd backend

# Create Procfile
echo "web: java -jar target/nsepulse-0.0.1-SNAPSHOT.jar" > Procfile

# Deploy
heroku login
heroku create stock-tracker-backend
git push heroku main
```

**Cost:** Starts at $7/month

---

### Option 5: Frontend Only - Netlify/Vercel (Free)

**Best for frontend hosting:**

**Netlify:**
```bash
cd frontend

# Build
npm run build

# Install Netlify CLI
npm install -g netlify-cli

# Deploy
netlify deploy --prod
```

**Vercel:**
```bash
cd frontend

# Install Vercel CLI
npm install -g vercel

# Deploy
vercel
```

Both offer:
- ✅ Free tier
- ✅ Automatic HTTPS
- ✅ CDN
- ✅ GitHub integration

**Note:** Backend needs separate hosting (Railway/Render recommended)

---

## 🔥 Recommended Deployment Strategy

### For Development/Testing:
- **Backend:** Railway (Free)
- **Frontend:** Netlify (Free)

### For Production:
- **Backend:** AWS Elastic Beanstalk or Render
- **Frontend:** Vercel with CDN
- **Database:** If needed, use Railway Postgres or AWS RDS

---

## 📝 Environment Configuration

Create `.env` file in backend if needed:
```properties
# Backend port
SERVER_PORT=8080

# CORS allowed origins (update after frontend deployment)
CORS_ALLOWED_ORIGINS=http://localhost:3000,https://your-frontend.netlify.app
```

Update frontend API URL in `src/config.js` or similar:
```javascript
const API_URL = process.env.REACT_APP_API_URL || 'http://localhost:8080';
```

---

## 🐛 Troubleshooting

**Backend won't start:**
- Check Java version: `java -version` (must be 17+)
- Check port 8080 is free: `lsof -i :8080`

**Frontend won't start:**
- Delete `node_modules` and run `npm install` again
- Check Node version: `node --version` (must be 16+)

**CORS errors:**
- Add frontend URL to backend CORS configuration
- Check `@CrossOrigin` annotation in Spring controllers

---

## 📚 Next Steps

1. Install Java 17 and Node.js
2. Run locally to test
3. Choose hosting option (Railway + Netlify recommended for free tier)
4. Deploy backend first, get URL
5. Update frontend API URL with backend URL
6. Deploy frontend
7. Test the deployed application

---

## 🔗 Useful Links

- **Railway:** https://railway.app
- **Render:** https://render.com
- **Netlify:** https://www.netlify.com
- **Vercel:** https://vercel.com
- **AWS Elastic Beanstalk:** https://aws.amazon.com/elasticbeanstalk
