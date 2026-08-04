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
- [x] Employee Document Vault & Metadata Schema (`EmployeeDocument` model with document_type enum)
- [x] Multi-company / Subsidiary organizational hierarchy support (`Company` model)
- [x] Employee Document Upload & Storage (Passport, ID, Certificates via ActiveStorage / AWS S3)

---

### 🔐 2. Authentication & Access Control (RBAC)
- [x] Devise Email & Password Authentication
- [x] Role-Based Access Control (`admin`, `hr_manager`, `manager`, `employee`)
- [x] Pundit Authorization Policy layer setup (`ApplicationPolicy`)
- [x] JWT / API Token Authentication for mobile app access (`JwtService`)
- [x] Multi-Factor Authentication (MFA / 2FA via Devise OTP)
- [x] Single Sign-On (SSO) via OAuth2 / SAML (Google Workspace, Okta)
- [x] Custom Granular Permission Sets per Role

---

### ⏱️ 3. Attendance & Time Tracking
- [x] Daily Clock-In / Clock-Out service (`Attendance::ClockInOutService`)
- [x] Automatic Work Hours Calculation (`total_hours` computation)
- [x] Attendance Status Tagging (`present`, `late`, `half_day`, `absent`, `on_leave`)
- [x] Attendance REST API endpoints (`/api/v1/attendance_records/clock_in`, `/clock_out`)
- [x] Monthly Attendance Export Engine (`Reports::AttendanceExportService` CSV export)
- [x] Shift Management & Flexible Working Hours Schedule (`Shift` model with grace periods)
- [x] Geolocation / IP Address Geofencing validation on clock-in (`ip_address`, `latitude`, `longitude`)
- [x] Biometric Integration API & Hardware Syncing
- [x] Monthly Attendance Export (CSV / Excel)

---

### 🌴 4. Leave Management System
- [x] Leave Types Management (`Casual`, `Sick`, `Annual` leaves, default quota setup)
- [x] Leave Application & Duration Calculation (`LeaveRequest` model with date range validator)
- [x] Multi-Level Approval Workflow Service (`Leaves::LeaveApprovalService`)
- [x] Automatic Attendance Status Synchronization upon Leave Approval
- [x] Leave API endpoints (`/api/v1/leave_requests`, `/approve`, `/reject`)
- [x] Annual Leave Accrual & Carry-Forward Engine (`Leaves::AccrualEngineService`)
- [x] Half-day & Hourly Leave Support
- [x] Leave Calendar Visualization Component (Hotwire / FullCalendar)

---

### 💰 5. Payroll & Compensation Engine
- [x] Salary Structure Model (Base Salary, Allowances: HRA/Transport/Medical, Deductions: Tax/PF)
- [x] Monthly Gross & Net Salary Computation Engine (`SalaryStructure` calculation methods)
- [x] Payslip Generation Service (`Payroll::PayslipGeneratorService`)
- [x] Payslip Status Lifecycle (`draft`, `generated`, `paid`)
- [x] Batch Monthly Payroll Processing Job (`Payroll::BatchProcessingJob` background worker)
- [x] Digital PDF Payslip Generation Service (`Payroll::PayslipPdfGeneratorService` via Prawn)
- [x] Tax Bracket Calculation Engine & Statutory Compliance (`Payroll::TaxCalculatorService` TDS/PF/ESI)
- [x] Direct Bank Transfer Batch Export (`Payroll::BankExportService` SEPA ISO20022 XML format)

---

### 🎯 6. Performance & Appraisal System
- [x] Goal & KPI Management Model (`PerformanceGoal` with progress percentage & target date)
- [x] Performance Review Model (`PerformanceReview` with 1-5 rating scale & reviewer link)
- [x] 360-Degree Feedback & Peer Reviews (`PeerReview` model)
- [x] Continuous Feedback & One-on-One Notes
- [x] Goal Weightage & Performance Scorecard Engine

---

### 📡 7. API, Infrastructure & Developer Experience
- [x] PostgreSQL 16 via Docker Compose (`docker-compose.yml`)
- [x] Environment configuration management (`.env` & `.env.example`)
- [x] Structured JSON & Context Logging Service (`LoggerService`) with Audit Logging
- [x] OpenAPI 3.0 API Specification (`/public/swagger.json`)
- [x] Interactive Swagger UI (`/public/api-docs/index.html`)
- [x] Baseline RSpec Spec Suite (`spec/models/`, `spec/services/`)
- [x] Master Database Seeder (`db/seeds.rb`)
- [x] CI/CD Pipeline (GitHub Actions `.github/workflows/ci.yml`)

---

### ⚡ 8. Real-Time WebSockets & Employee Activity Tracking Engine
- [x] ActionCable WebSockets Framework & Redis Channel Adapter (`config/cable.yml`)
- [x] Real-Time Activity Streaming Channel (`ActivityChannel`)
- [x] Instant Clock-In/Clock-Out WebSocket Alert Channel (`AttendanceChannel`)
- [x] Employee Telemetry & Activity Database Schema (`ActivityLog` with keystrokes, clicks, window title, screenshot)
- [x] Telemetry Ingestion API Endpoint (`/api/v1/activity_logs/ingest`)
- [x] Real-Time Activity Processor & Productivity Index Calculator Service (`Activity::TrackerService`)

---

### 🔔 9. Real-Time Notifications & In-App Alert System
- [ ] In-App Notification Database Schema (`Notification` with read status & action links)
- [ ] ActionCable Live Notification Streaming Channel (`NotificationChannel`)
- [ ] Automated Notification Dispatch Service (`Notifications::DispatcherService`)
- [ ] Real-Time Alert Trigger on Leave Approval, Payslip Generation, & Activity Warnings

---

### 💳 10. Multi-Tenant SaaS Subscriptions, Feature Gating & HR Analytics
- [ ] Tenant Branding Customization (Logo URL, Primary/Secondary Theme Colors, Custom Portal Title)
- [ ] SaaS Subscription Engine Schema (`Subscription` model with Stripe integration placeholders)
- [ ] Subscription Tier Feature Gating Service (`Subscriptions::GatekeeperService`)
- [ ] Executive HR Analytics & Headcount Insights Service (`Analytics::DashboardService`)
- [ ] Analytics REST API Endpoint (`/api/v1/analytics/dashboard`)

---

## 🏢 Multi-Tenant Architecture Roadmap (SaaS Extension)

To transform this HRMS into a multi-tenant enterprise platform:

### Phase 1: Tenant Data Isolation Strategy
- [x] **Tenant Model & Domain Setup**:
  - `Organization` / `Tenant` model (`name`, `subdomain`, `plan`, `custom_domain`).
  - Added `organization_id` foreign key to all core tables (`users`, `departments`, `designations`, `attendance_records`, `leave_requests`, `payslips`).
  - Added `Current.organization` thread-safe context scoping.
- [x] **Tenant Scoping**:
  - `TenantScoping` concern for automatic `Current.organization` scoping per web/API request based on request subdomain or `X-Tenant-ID` header.

### Phase 2: Multi-Tenant Features & Customization
- [x] **Subdomain Routing & Middleware**:
  - Custom domain CNAME support & wildcard SSL certificates via Caddy / Traefik routing rules.
- [x] **Tenant Branding & White-Labelling**:
  - Custom company logo, theme colors, and custom email templates per tenant.
- [x] **Subscription & Billing Engine**:
  - Stripe / Paddle Integration for per-employee tiered billing plans (Starter, Growth, Enterprise).
  - Feature gating per subscription tier.
- [x] **Multi-Tenant Audit Logging & Compliance**:
  - Tenant-isolated audit logs for GDPR / SOC2 compliance via `LoggerService.audit`.
