#  Containerized Web Application with PostgreSQL using Docker Compose and IPvlan

##  Project Assignment 1  
**Subject:** Containerization and DevOps  

---
## 📸 Screenshots
## 📸 Screenshots

### 🔹 Docker Compose Running
![Compose](screenshots/screenshot1.png)

### 🔹 Running Containers
![Containers](screenshots/screenshot2.png)

### 🔹 Network Inspect
![Network](screenshots/screenshot3.png)

### 🔹 Container IP Address
![IP](screenshots/screenshot4.png)

### 🔹 Health API
![Health](screenshots/screenshot5.png)

### 🔹 Insert API
![Insert](screenshots/screenshot6.png)

### 🔹 Fetch API
![Fetch](screenshots/screenshot7.png)
##  Overview

This project demonstrates a containerized web application using **FastAPI** and **PostgreSQL**.  
Both services run in separate Docker containers and are orchestrated using **Docker Compose**.

Networking is implemented using **IPvlan**, where each container is assigned a **static IP address**.

---

## Project Architecture

Client (Browser / Postman)  
        │  
        │ HTTP  
        ▼  
Backend Container (FastAPI)  
IP: 172.22.208.11  
        │  
        │ PostgreSQL Connection  
        ▼  
PostgreSQL Container  
IP: 172.22.208.10  
        │  
        ▼  
Docker Volume (pgdata)  

---

## ⚙️ Prerequisites

Make sure Docker is installed:

```bash
docker --version
docker compose version

📁 Project Structure


docker-webapp/
│
├── backend/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── database/
│   ├── Dockerfile
│   └── init.sql
│
└── docker-compose.yml

 Step 1 — Create Project Directory

mkdir docker-webapp
cd docker-webapp

Step 2 — Create Backend and Database Directories
mkdir backend
mkdir database

 Step 3 — Create IPvlan Network
docker network create -d ipvlan \
--subnet=172.22.208.0/24 \
--gateway=172.22.208.1 \
-o parent=eth0 mynetwork

 Step 4 — Verify Network
docker network ls
docker network inspect mynetwork

Step 5 — Build and Start Containers
docker compose up --build

 Step 6 — Verify Running Containers
docker ps

 Step 7 — Verify Container IP Addresses
docker inspect backend_api | grep IPAddress
docker inspect postgres_db | grep IPAddress

Expected Output:

Backend IP   → 172.22.208.11  
Database IP  → 172.22.208.10  

 Step 8 — Test API Endpoints
 Health Check
GET http://172.22.208.11:8000/health

Response:

{
  "status": "healthy"
}
➕ Insert Record
POST http://172.22.208.11:8000/items?name=test

Response:

{
  "message": "Item inserted successfully",
  "name": "test"
}

 Fetch Records
GET http://172.22.208.11:8000/items

Response:

[
  {
    "id": 1,
    "name": "test"
  }
]

 Step 9 — Volume Persistence Test
docker compose down
docker compose up

Check data again:

GET /items

 Data persists after restart

Step 10 — Verify Volume
docker volume ls

Example:

docker-webapp_pgdata
⚡ Build Optimization

Multi-stage builds reduce image size

Slim base images reduce dependencies

.dockerignore improves build efficiency

Non-root user enhances security

Volumes ensure persistent storage


 Image Size Comparison
Image	Size
python:3.11	~1GB
python:3.11-slim	~150MB

Macvlan vs IPvlan
Feature	Macvlan	IPvlan
MAC Address	Unique per container	Shared with host
Network Load	Higher	Lower
Scalability	Limited	High
Use Case	Small LAN	Cloud / Virtual Environments

 Limitations

In WSL environment, host-to-container communication may not work due to kernel restrictions.

 Conclusion

This project successfully demonstrates:

FastAPI backend container

PostgreSQL database container

Docker Compose orchestration

IPvlan networking with static IP

Persistent storage using volumes

Optimized Docker image builds

The system ensures scalability, portability, and reliability.

 Author

Name: Nipun Agrawal
Course: B.Tech Computer Science