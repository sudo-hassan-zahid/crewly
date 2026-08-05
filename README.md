# Crewly - Human Resource Management System (HRMS)

<p align="center">
  <img src="https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white" alt="Ruby" />
  <img src="https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white" alt="Rails" />
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL" />
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker" />
  <img src="https://img.shields.io/badge/Swagger-85EA2D?style=for-the-badge&logo=swagger&logoColor=black" alt="Swagger" />
  <img src="https://img.shields.io/badge/RSpec-C21325?style=for-the-badge&logo=rspec&logoColor=white" alt="RSpec" />
</p>

A clean, scalable, production-grade **Human Resource Management System (HRMS)** built with **Ruby on Rails 7**, **PostgreSQL 16**, **Docker Compose**, **Devise Authentication**, **Pundit Authorization**, structured logging, and interactive OpenAPI 3.0 (Swagger) documentation.

---

## What Runs In Docker

This repo now includes a Dockerized development path for:

- Rails app server
- PostgreSQL database

That means you do not need to install a specific Ruby version on Windows if you use Docker for development.

---

## Key Features

- Core HR & org hierarchy
- Role-based access control
- Attendance and shift tracking
- Leave management
- Payroll and PDF payslips
- Employee document vault
- Real-time activity tracking
- Real-time notifications
- Multi-tenant SaaS and feature gating
- HR analytics dashboard

---

## Docker-First Quick Start

### Prerequisites

- Docker Desktop
- Git

Optional:

- Windows Terminal or PowerShell 7

### 1. Clone & Configure

```powershell
git clone git@github.com:sudo-hassan-zahid/hrms-ror.git
cd hrms-ror
Copy-Item .env.example .env
```

### 2. Build And Start The Containers

```powershell
docker compose up --build
```

### 3. Prepare The Database

Open a second terminal and run:

```powershell
docker compose run --rm web bin/rails db:prepare
docker compose run --rm web bin/rails db:seed
```

### 4. Open The App

Open [http://localhost:3000](http://localhost:3000) in your browser.

---

## Daily Development

- Start everything:
  ```powershell
  docker compose up
  ```
- Run a Rails command inside the app container:
  ```powershell
  docker compose run --rm web bin/rails console
  ```
- Run the test suite:
  ```powershell
  docker compose run --rm web bundle exec rspec
  ```

---

## Notes

- The app container uses Ruby `3.3.12`.
- The database container uses PostgreSQL `16`.
- Development ActionCable uses the async adapter, so Redis is not required for local development.
- If you want to run Rails directly on Windows instead of Docker, the project still supports that path, but Docker is now the recommended way to avoid local version drift.

---

## Documentation & Tracking

- [AGENTS.md](/F:/crewly/AGENTS.md): Master feature matrix, completion status checklist, and multi-tenant SaaS roadmap.
- [OpenAPI Spec](/F:/crewly/public/swagger.json): Full OpenAPI 3.0 JSON schema.
