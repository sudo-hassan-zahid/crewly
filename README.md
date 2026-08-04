# 🏢 Crewly - Human Resource Management System (HRMS)

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

## 🌟 Key Features & Architecture

- **🏢 Core HR & Org Hierarchy**: Departments, Designations, Employee Directory, Manager reporting structure.
- **🔐 Multi-Role Access Control (RBAC)**: Admin, HR Manager, Line Manager, and Employee roles via `Pundit`.
- **⏱️ Attendance & Shift Engine**: Clock-in/out service, auto work-hours calculation, late tagging, geofence/IP validation.
- **🌴 Leave Management System**: Multi-level leave approvals, auto attendance sync, duration calculators.
- **💰 Payroll Computation & PDF Payslips**: Monthly salary structure calculation engine, PDF payslip generator via Prawn, batch processing via Sidekiq/ActiveJob.
- **📄 Employee Document Vault**: Document attachment storage via ActiveStorage.
- **⚡ Real-Time Activity Tracking & WebSockets**: Live keystroke, mouse click, active window, and screenshot streaming via ActionCable (`ActivityChannel`).
- **🔔 Real-Time In-App Notifications**: Instant push alerts via ActionCable (`NotificationChannel` & `DispatcherService`).
- **💳 Multi-Tenant SaaS & Feature Gating**: Multi-tenant data isolation (`Organization` & `Current`), subdomain routing, and plan-tier feature gating via `Subscriptions::GatekeeperService`.
- **📊 Executive HR Analytics**: Real-time headcount statistics, attendance rates, and 24h productivity score metrics (`/api/v1/analytics/dashboard`).
- **📡 REST API & Interactive Swagger UI**: Complete API documentation served live at `/api-docs/index.html`.
- **📊 Multi-Tenant Architecture Roadmap**: Multi-tenant database isolation, subdomain routing, and SaaS billing expansion specs in `AGENTS.md`.

---

## 🚀 Quick Start (Docker Environment)

### Prerequisites
- Docker Engine & Docker Compose
- Ruby 3.3+ and Rails 7+ (for local host execution)

### 1. Clone & Environment Setup
```bash
git clone git@github.com:sudo-hassan-zahid/hrms-ror.git
cd hrms-ror
cp .env.example .env
```

### 2. Start PostgreSQL via Docker Compose
```bash
docker-compose up -d
```

### 3. Setup Database & Seed Data
```bash
bin/rails db:prepare
bin/rails db:seed
```

### 4. Run Rails Development Server
```bash
bin/rails server -p 3000
```
Open [http://localhost:3000](http://localhost:3000) in your browser to view the interactive **Swagger UI** API documentation.

---

## 🧪 Running Unit & Integration Tests

```bash
bundle exec rspec
```

---

## 📜 Documentation & Tracking

- 📄 **[AGENTS.md](file:///j:/hrms-ror/AGENTS.md)**: Master feature matrix, completion status checklist, and multi-tenant SaaS roadmap.
- 📄 **[OpenAPI Spec](file:///j:/hrms-ror/public/swagger.json)**: Full OpenAPI 3.0 JSON schema.
