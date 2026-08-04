# HRMS Feature Matrix & Multi-Tenant Roadmap

This document serves as the master tracking checklist for the Human Resource Management System (HRMS) built with Ruby on Rails & PostgreSQL.

---

## 📊 Feature Checklist Status

### 🏢 1. Organization & Core HR Management
- [x] Department Management (CRUD, code uniqueness, active status tracking)
- [x] Designation / Job Titles (Linked to departments, unique codes)
- [x] Employee Profiles (Devise integration, personal info, date of joining, contact details)
- [x] Employment Status Tracking (`active`, `on_leave`, `terminated`)
- [x] Reporting Hierarchy (`manager_id` self-referential association for Org Chart)
- [x] Bank Account & Financial Details Schema
- [ ] Multi-company / Subsidiary organizational hierarchy support
- [ ] Employee Document Upload & Storage (Passport, ID, Certificates via ActiveStorage / AWS S3)

---

### 🔐 2. Authentication & Access Control (RBAC)
- [x] Devise Email & Password Authentication
- [x] Role-Based Access Control (`admin`, `hr_manager`, `manager`, `employee`)
- [x] Pundit Authorization Policy layer setup (`ApplicationPolicy`)
- [ ] JWT / API Token Authentication for mobile app access
- [ ] Multi-Factor Authentication (MFA / 2FA via Devise OTP)
- [ ] Single Sign-On (SSO) via OAuth2 / SAML (Google Workspace, Okta)
- [ ] Custom Granular Permission Sets per Role

---

### ⏱️ 3. Attendance & Time Tracking
- [x] Daily Clock-In / Clock-Out service (`Attendance::ClockInOutService`)
- [x] Automatic Work Hours Calculation (`total_hours` computation)
- [x] Attendance Status Tagging (`present`, `late`, `half_day`, `absent`, `on_leave`)
- [x] Attendance REST API endpoints (`/api/v1/attendance_records/clock_in`, `/clock_out`)
- [ ] Geolocation / IP Address Geofencing validation on clock-in
- [ ] Shift Management & Flexible Working Hours Schedule
- [ ] Biometric Integration API & Hardware Syncing
- [ ] Monthly Attendance Export (CSV / Excel)

---

### 🌴 4. Leave Management System
- [x] Leave Types Management (`Casual`, `Sick`, `Annual` leaves, default quota setup)
- [x] Leave Application & Duration Calculation (`LeaveRequest` model with date range validator)
- [x] Multi-Level Approval Workflow Service (`Leaves::LeaveApprovalService`)
- [x] Automatic Attendance Status Synchronization upon Leave Approval
- [x] Leave API endpoints (`/api/v1/leave_requests`, `/approve`, `/reject`)
- [ ] Annual Leave Accrual & Carry-Forward Engine
- [ ] Half-day & Hourly Leave Support
- [ ] Leave Calendar Visualization Component (Hotwire / FullCalendar)

---

### 💰 5. Payroll & Compensation Engine
- [x] Salary Structure Model (Base Salary, Allowances: HRA/Transport/Medical, Deductions: Tax/PF)
- [x] Monthly Gross & Net Salary Computation Engine (`SalaryStructure` calculation methods)
- [x] Payslip Generation Service (`Payroll::PayslipGeneratorService`)
- [x] Payslip Status Lifecycle (`draft`, `generated`, `paid`)
- [ ] Batch Monthly Payroll Processing Job (Sidekiq background worker)
- [ ] Digital PDF Payslip Generation & Email Delivery (Prawn gem)
- [ ] Tax Bracket Calculation Engine & Statutory Compliance (PF, ESI, TDS)
- [ ] Direct Bank Transfer Batch Export (NACH / SEPA XML format)

---

### 🎯 6. Performance & Appraisal System
- [x] Goal & KPI Management Model (`PerformanceGoal` with progress percentage & target date)
- [x] Performance Review Model (`PerformanceReview` with 1-5 rating scale & reviewer link)
- [ ] 360-Degree Feedback & Peer Reviews
- [ ] Continuous Feedback & One-on-One Notes
- [ ] Goal Weightage & Performance Scorecard Engine

---

### 📡 7. API, Infrastructure & Developer Experience
- [x] PostgreSQL 16 via Docker Compose (`docker-compose.yml`)
- [x] Environment configuration management (`.env` & `.env.example`)
- [x] Structured JSON & Context Logging Service (`LoggerService`) with Audit Logging
- [x] OpenAPI 3.0 API Specification (`/public/swagger.json`)
- [x] Interactive Swagger UI (`/public/api-docs/index.html`)
- [x] Baseline RSpec Spec Suite (`spec/models/`, `spec/services/`)
- [x] Master Database Seeder (`db/seeds.rb`)
- [ ] CI/CD Pipeline (GitHub Actions for RSpec & RuboCop)

---

## 🏢 Multi-Tenant Architecture Roadmap (SaaS Extension)

To transform this HRMS into a multi-tenant enterprise platform:

### Phase 1: Tenant Data Isolation Strategy
- [ ] **Tenant Model & Domain Setup**:
  - `Organization` / `Tenant` model (`name`, `subdomain`, `plan`, `custom_domain`).
  - Add `tenant_id` foreign key to all core tables (`users`, `departments`, `designations`, `attendance_records`, `leave_requests`, `payslips`).
- [ ] **Tenant Scoping**:
  - Integrate `acts_as_tenant` gem or Row-Level Security (RLS) policies in PostgreSQL.
  - Automatic `Current.tenant` scoping per web/API request based on request subdomain (`company.hrms.com`) or `X-Tenant-ID` header.

### Phase 2: Multi-Tenant Features & Customization
- [ ] **Subdomain Routing & Middleware**:
  - Custom domain CNAME support & wildcard SSL certificates via Caddy / Traefik.
- [ ] **Tenant Branding & White-Labelling**:
  - Custom company logo, theme colors, and custom email templates per tenant.
- [ ] **Subscription & Billing Engine**:
  - Stripe / Paddle Integration for per-employee tiered billing plans (Starter, Growth, Enterprise).
  - Feature gating per subscription tier (e.g. Payroll module unlocked on Growth plan only).
- [ ] **Multi-Tenant Audit Logging & Compliance**:
  - Tenant-isolated audit logs for GDPR / SOC2 compliance.
