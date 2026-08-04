# HRMS Seed Data

puts "Seeding Departments..."
eng = Department.find_or_create_by!(code: "ENG") { |d| d.name = "Engineering"; d.description = "Software engineering and R&D" }
hr = Department.find_or_create_by!(code: "HR") { |d| d.name = "Human Resources"; d.description = "People operations and talent acquisition" }
fin = Department.find_or_create_by!(code: "FIN") { |d| d.name = "Finance"; d.description = "Payroll, accounting, and financial planning" }

puts "Seeding Designations..."
dev = Designation.find_or_create_by!(code: "SE", department: eng) { |d| d.title = "Software Engineer" }
hr_lead = Designation.find_or_create_by!(code: "HRL", department: hr) { |d| d.title = "HR Lead" }

puts "Seeding Leave Types..."
LeaveType.find_or_create_by!(code: "CL") { |lt| lt.name = "Casual Leave"; lt.default_days_per_year = 12; lt.paid = true }
LeaveType.find_or_create_by!(code: "SL") { |lt| lt.name = "Sick Leave"; lt.default_days_per_year = 10; lt.paid = true }
LeaveType.find_or_create_by!(code: "AL") { |lt| lt.name = "Annual Leave"; lt.default_days_per_year = 15; lt.paid = true }

puts "Seeding Users..."
admin = User.find_or_create_by!(email: "admin@hrms.local") do |u|
  u.first_name = "System"
  u.last_name = "Admin"
  u.password = "password123"
  u.employee_number = "EMP001"
  u.role = :admin
  u.department = hr
  u.designation = hr_lead
  u.date_of_joining = Date.new(2024, 1, 1)
end

employee = User.find_or_create_by!(email: "john.doe@hrms.local") do |u|
  u.first_name = "John"
  u.last_name = "Doe"
  u.password = "password123"
  u.employee_number = "EMP002"
  u.role = :employee
  u.department = eng
  u.designation = dev
  u.manager = admin
  u.date_of_joining = Date.new(2024, 6, 1)
end

puts "Seeding Salary Structure..."
SalaryStructure.find_or_create_by!(user: employee) do |ss|
  ss.base_salary = 6000.00
  ss.housing_allowance = 1200.00
  ss.transport_allowance = 400.00
  ss.medical_allowance = 300.00
  ss.tax_deduction = 500.00
  ss.provident_fund_deduction = 200.00
end

puts "Database successfully seeded for HRMS!"
