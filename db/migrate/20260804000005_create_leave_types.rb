class CreateLeaveTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :leave_types do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.integer :default_days_per_year, default: 12, null: false
      t.boolean :paid, default: true, null: false

      t.timestamps
    end
    add_index :leave_types, :code, unique: true
  end
end
