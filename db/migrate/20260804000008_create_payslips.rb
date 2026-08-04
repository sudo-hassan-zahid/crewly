class CreatePayslips < ActiveRecord::Migration[7.1]
  def change
    create_table :payslips do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :month, null: false # 1-12
      t.integer :year, null: false
      t.decimal :gross_salary, precision: 12, scale: 2, null: false
      t.decimal :total_allowances, precision: 10, scale: 2, default: 0.0
      t.decimal :total_deductions, precision: 10, scale: 2, default: 0.0
      t.decimal :net_salary, precision: 12, scale: 2, null: false
      t.integer :status, default: 0, null: false # 0: draft, 1: generated, 2: paid
      t.date :payment_date

      t.timestamps
    end

    add_index :payslips, [:user_id, :month, :year], unique: true
  end
end
