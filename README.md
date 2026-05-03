# Web Server using Docker

This project demonstrates deploying and managing a web server inside Docker containers. It includes a simple Node.js Express application containerized and managed through Docker and Docker Compose.

## Docker Containerization Basics

### What is Docker?
Docker is a platform for developing, shipping, and running applications inside containers. Containers are lightweight, portable, and self-sufficient units that package an application and its dependencies.

### Key Concepts:
- **Images**: Read-only templates used to create containers
- **Containers**: Running instances of images
- **Dockerfile**: Instructions for building an image
- **Registry**: Repository for storing and sharing images (like Docker Hub)

## Project Structure

```
.
├── app.js              # Node.js web server application
├── package.json        # Node.js dependencies and scripts
├── Dockerfile          # Instructions to build the Docker image
├── docker-compose.yml  # Multi-container Docker application definition
├── .dockerignore       # Files to exclude from Docker build context
└── README.md          # This file
```

## Deploy and Manage Web Server

### Prerequisites
- [Node.js](https://nodejs.org/) (for local testing)
- [Docker](https://docs.docker.com/get-docker/) installed on your system
- [Docker Compose](https://docs.docker.com/compose/install/) installed

### Installation Instructions
**Windows:**
1. Download Docker Desktop from https://www.docker.com/products/docker-desktop
2. Install and start Docker Desktop
3. Verify installation: `docker --version`

**Linux/Mac:**
Follow the instructions at https://docs.docker.com/get-docker/

### Building and Running

1. **Build the Docker image:**
   ```bash
   docker build -t web-server .
   ```

2. **Run the container:**
   ```bash
   docker run -p 3000:3000 web-server
   ```

3. **Using Docker Compose (recommended):**
   ```bash
   docker-compose up --build
   ```

4. **Run in background:**
   ```bash
   docker-compose up -d --build
   ```

### Accessing the Application
- Web server: http://localhost:3000
- Health check: http://localhost:3000/health
- API info: http://localhost:3000/api/info

## Container Lifecycle and Commands

### Container States:
- **Created**: Container has been created but not started
- **Running**: Container is actively executing
- **Paused**: Container execution is suspended
- **Stopped**: Container has finished execution
- **Exited**: Container has stopped with an exit code

### Essential Docker Commands:

```bash
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Start a stopped container
docker start <container_id>

# Stop a running container
docker stop <container_id>

# Restart a container
docker restart <container_id>

# Remove a stopped container
docker rm <container_id>

# View container logs
docker logs <container_id>

# Execute commands inside a running container
docker exec -it <container_id> /bin/sh

# View container resource usage
docker stats <container_id>

# Clean up unused resources
docker system prune
```

### Docker Compose Commands:

```bash
# Start services
docker-compose up

# Start services in background
docker-compose up -d

# Stop services
docker-compose down

# View service logs
docker-compose logs

# Rebuild and restart services
docker-compose up --build

# Scale services
docker-compose up --scale web-server=3
```

## Monitor Container Health and Troubleshoot Issues

### Health Checks
This project includes a health check endpoint (`/health`) and Docker health monitoring configured in `docker-compose.yml`.

### Monitoring Commands:

```bash
# View real-time container stats
docker stats

# Check container health
docker ps --format "table {{.Names}}\t{{.Status}}"

# View logs
docker-compose logs -f web-server

# Inspect container details
docker inspect <container_id>
```

### Troubleshooting Common Issues:

1. **Port already in use:**
   ```bash
   # Find process using port 3000
   netstat -ano | findstr :3000
   # Kill the process or change port mapping
   ```

2. **Container won't start:**
   ```bash
   # Check logs for errors
   docker-compose logs web-server
   # Validate Dockerfile syntax
   docker build --no-cache .
   ```

3. **Application not responding:**
   ```bash
   # Check if container is running
   docker ps
   # Test health endpoint
   curl http://localhost:3000/health
   # Check application logs inside container
   docker exec -it <container_id> tail -f /app/logs/app.log
   ```

4. **High resource usage:**
   ```bash
   # Monitor resource usage
   docker stats
   # Limit container resources in docker-compose.yml
   deploy:
     resources:
       limits:
         cpus: '0.50'
         memory: 512M
   ```

## Container-Based App Deployment Best Practices

### 1. **Use Multi-Stage Builds**
For compiled languages, use multi-stage builds to reduce final image size:

```dockerfile
# Build stage
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Production stage
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
EXPOSE 3000
CMD ["npm", "start"]
```

### 2. **Security Best Practices**
- Use non-root users
- Scan images for vulnerabilities
- Keep base images updated
- Use specific image tags (avoid `latest`)

### 3. **Optimize Image Size**
- Use `.dockerignore` to exclude unnecessary files
- Chain RUN commands to reduce layers
- Use smaller base images (alpine variants)
- Clean up package manager cache

### 4. **Configuration Management**
- Use environment variables for configuration
- Store secrets securely (not in images)
- Use Docker secrets or external config services

### 5. **Logging and Monitoring**
- Implement structured logging
- Use health checks
- Monitor resource usage
- Set up log aggregation

### 6. **Networking**
- Use internal networks for service communication
- Expose only necessary ports
- Use reverse proxies for production

### 7. **Data Persistence**
- Use volumes for persistent data
- Implement backup strategies
- Separate data from application code

### 8. **Scalability**
- Design for horizontal scaling
- Use load balancers
- Implement proper session management

## Learning Outcomes

By completing this task, you have learned:
- ✅ Docker containerization fundamentals
- ✅ How to deploy web applications in containers
- ✅ Container lifecycle management
- ✅ Health monitoring and troubleshooting techniques
- ✅ Best practices for container-based deployments

## Next Steps

- Explore Docker Swarm or Kubernetes for orchestration
- Implement CI/CD pipelines with Docker
- Learn about Docker security scanning
- Experiment with different application stacks (Python, Java, etc.)