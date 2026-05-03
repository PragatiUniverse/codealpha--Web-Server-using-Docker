const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

// Middleware to parse JSON
app.use(express.json());

// Basic route
app.get('/', (req, res) => {
  res.json({
    message: 'Hello World from Docker!',
    timestamp: new Date().toISOString(),
    container: process.env.HOSTNAME || 'unknown'
  });
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'healthy' });
});

// API route
app.get('/api/info', (req, res) => {
  res.json({
    app: 'Docker Web Server',
    version: '1.0.0',
    environment: process.env.NODE_ENV || 'development',
    uptime: process.uptime()
  });
});

app.listen(port, () => {
  console.log(`Web server running on port ${port}`);
});