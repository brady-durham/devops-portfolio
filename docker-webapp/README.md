# Docker Web Application

Containerized Python Flask web application demonstrating Docker fundamentals.

## Project Overview

Built a simple web application and containerized it using Docker, demonstrating the ability to package applications with their dependencies for consistent deployment across environments.

---

## What Was Built

**Application:**
- Python Flask web server
- Serves HTML response on port 5000
- Minimal web application for learning Docker

**Container:**
- Based on Python 3.9 slim image
- Includes Flask dependency
- Exposes port 5000
- Runs application automatically on start

---

## Docker Concepts Demonstrated

### 1. Container Images
Created a Docker image from a Dockerfile that defines:
- Base image (Python 3.9)
- Working directory
- Application files
- Dependencies (Flask)
- Port exposure
- Startup command

### 2. Building Images
```bash
docker build -t my-webapp .
```
Builds an image from the Dockerfile and tags it as "my-webapp"

### 3. Running Containers
```bash
docker run -d -p 5000:5000 --name webapp my-webapp
```
- `-d` = detached mode (background)
- `-p 5000:5000` = port mapping (host:container)
- `--name webapp` = friendly container name

### 4. Container Management
- `docker ps` - View running containers
- `docker stop` - Stop container
- `docker logs` - View container output

---

## Why Containerization Matters

**Benefits Experienced:**

**Isolation:**
- Application runs in its own environment
- No conflicts with host system
- Predictable behavior

**Portability:**
- Same container runs anywhere Docker is installed
- "Works on my machine" problem solved
- Consistent from development to production

**Reproducibility:**
- Dockerfile defines exact environment
- Anyone can rebuild identical container
- Version controlled infrastructure

**Efficiency:**
- Lightweight compared to VMs
- Fast startup (seconds vs minutes)
- Resource efficient

---

## Screenshots

**Dockerfile Contents:**
![Dockerfile](screenshots/Screenshot%20from%202025-12-02%2017-29-31.png)

**Docker Build Process:**
![Build](screenshots/Screenshot%20from%202025-12-02%2017-30-52.png)

**Container Running:**
![Running Container](screenshots/Screenshot%20from%202025-12-02%2017-31-37.png)

**Web Application in Browser:**
![Web App](screenshots/Screenshot%20from%202025-12-02%2017-32-22.png)

---

## Skills Demonstrated

- Docker fundamentals
- Dockerfile creation
- Container image building
- Port mapping
- Container lifecycle management
- Application containerization

---

## Files

- `app.py` - Flask web application
- `Dockerfile` - Container image definition

---

**Date Completed:** December 2, 2025
# CI/CD enabled
