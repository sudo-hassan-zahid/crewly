# Human Resource Management System (HRMS) - Feature Specification

## Overview
This document outlines the feature architecture and module specifications for the Ruby on Rails HRMS application.

---

## 1. Organization & Core HR Management
- **Company Hierarchy & Departments**: Create and manage Departments (e.g., Engineering, Human Resources, Finance, Marketing).
- **Designations & Job Titles**: Manage Job Roles and levels (e.g., Junior Engineer, HR Manager, Senior Accountant).
- **Employee Directory & Profiles**:
  - Personal Information (Full Name, Email, Phone, Emergency Contacts, Date of Birth).
  - Employment Details (Employee ID, Date of Joining, Department, Designation, Employment Status: Active / On Leave / Terminated).
  - Reporting Hierarchy (`manager_id` association for organizational org chart).
  - Bank Account & Tax ID details for Payroll.

---

## 2. Authentication & Authorization (RBAC)
- **Authentication**: Secure email & password authentication using `Devise`.
- **Role-Based Access Control (RBAC)** using `Pundit`:
  - **Admin**: Complete system access, system configurations, master data management.
  - **HR Manager**: Employee onboarding, leave approvals, payroll processing, performance review setup.
  - **Line Manager**: Direct report approvals (Leaves, Attendance adjustments, Team performance reviews).
  - **Employee**: Self-service portal (Clock in/out, view payslips, apply for leave, submit performance goals).

---

## 3. Attendance & Time Tracking
- **Daily Clock-In / Clock-Out**: Real-time time logging with IP/location tracking support.
- **Attendance Status Calculation**: Present, Late, Half-Day, Absent, On-Leave.
- **Work Logs & Timesheets**: Daily work summaries submitted by employees.
- **Attendance Analytics & Reports**: Monthly summaries for HR and Managers.

---

## 4. Leave Management System
- **Leave Types Configuration**: Sick Leave, Casual Leave, Paid Leave, Maternity/Paternity Leave, Unpaid Leave.
- **Leave Entitlements & Balances**: Automated annual/monthly leave quota allocation.
- **Leave Request & Multi-Level Approval Workflow**:
  - Employee submits request with date range & reason.
  - Manager / HR notification and Approval/Rejection interface.
  - Automatic balance deduction and attendance calendar sync upon approval.

---

## 5. Payroll & Compensation Management
- **Salary Structure Engine**:
  - Base Salary components.
  - Custom Allowances (HRA, Conveyance, Medical, Special).
  - Statutory & Custom Deductions (Income Tax, Provident Fund, Insurance).
- **Payslip Generation**: Monthly batch calculation service generating official digital payslips.
- **Payslip Export**: Printable layout and PDF export ready.

---

## 6. Performance & Appraisal System
- **Goal Setting (KPIs / OKRs)**: Define quarter/year goals per employee with progress tracking.
- **Performance Reviews**: Self-assessment and Manager review feedback cycles.
- **Rating Matrix**: Structured performance ratings and recommendations.

---

## Implementation Strategy & Tech Stack
- **Framework**: Ruby on Rails 7+
- **Database**: PostgreSQL 16 (via Docker Compose)
- **Gems**: `devise`, `pundit`, `pg`, `kaminari`, `bootstrap`/`tailwind` or custom CSS system
- **Design Pattern**: Service Objects for domain logic (Payroll processing, Leave calculation), Policy Objects for authorization, Query Objects for reports.
