class CreateShifts < ActiveRecord::Migration[7.1]
  def change
    create_table :shifts do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.integer :grace_period_minutes, default: 15, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :shifts, :code, unique: true
    add_reference :users, :shift, foreign_key: true, null: true
  end
end
