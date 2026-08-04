class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :subdomain, null: false
      t.string :plan, default: "starter", null: false
      t.string :custom_domain
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :organizations, :subdomain, unique: true
    add_index :organizations, :custom_domain, unique: true

    # Add tenant reference to core HRMS tables
    add_reference :users, :organization, foreign_key: true, null: true
    add_reference :departments, :organization, foreign_key: true, null: true
    add_reference :designations, :organization, foreign_key: true, null: true
    add_reference :attendance_records, :organization, foreign_key: true, null: true
    add_reference :leave_requests, :organization, foreign_key: true, null: true
    add_reference :payslips, :organization, foreign_key: true, null: true
  end
end
