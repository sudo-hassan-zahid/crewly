class CreateAttendanceRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :attendance_records do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.datetime :clock_in
      t.datetime :clock_out
      t.integer :status, default: 0, null: false # 0: present, 1: late, 2: half_day, 3: absent, 4: on_leave
      t.decimal :total_hours, precision: 5, scale: 2, default: 0.0
      t.text :notes

      t.timestamps
    end

    add_index :attendance_records, [:user_id, :date], unique: true
  end
end
