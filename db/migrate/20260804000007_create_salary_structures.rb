class CreateSalaryStructures < ActiveRecord::Migration[7.1]
  def change
    create_table :salary_structures do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :base_salary, precision: 12, scale: 2, null: false
      t.decimal :housing_allowance, precision: 10, scale: 2, default: 0.0
      t.decimal :transport_allowance, precision: 10, scale: 2, default: 0.0
      t.decimal :medical_allowance, precision: 10, scale: 2, default: 0.0
      t.decimal :tax_deduction, precision: 10, scale: 2, default: 0.0
      t.decimal :provident_fund_deduction, precision: 10, scale: 2, default: 0.0
      t.boolean :active, default: true, null: false

      t.timestamps
    end
  end
end
