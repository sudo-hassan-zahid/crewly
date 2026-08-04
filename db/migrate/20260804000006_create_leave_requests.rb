class CreateLeaveRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :leave_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :leave_type, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :total_days, null: false
      t.text :reason
      t.integer :status, default: 0, null: false # 0: pending, 1: approved, 2: rejected
      t.references :approved_by, foreign_key: { to_table: :users }, null: true
      t.text :rejection_reason

      t.timestamps
    end
  end
end
