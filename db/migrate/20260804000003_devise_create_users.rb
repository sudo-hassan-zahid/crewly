class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Personal & HR details
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :employee_number, null: false
      t.integer :role, default: 0, null: false # enum: 0: employee, 1: manager, 2: hr_manager, 3: admin
      t.integer :employment_status, default: 0, null: false # enum: 0: active, 1: on_leave, 2: terminated
      t.date :date_of_joining
      t.string :phone_number
      t.references :department, foreign_key: true, null: true
      t.references :designation, foreign_key: true, null: true
      t.references :manager, foreign_key: { to_table: :users }, null: true

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :employee_number,      unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
