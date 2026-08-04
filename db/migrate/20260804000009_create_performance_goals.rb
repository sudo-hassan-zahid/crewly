class CreatePerformanceGoals < ActiveRecord::Migration[7.1]
  def change
    create_table :performance_goals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.date :target_date
      t.integer :status, default: 0, null: false # 0: not_started, 1: in_progress, 2: completed, 3: cancelled
      t.integer :progress_percentage, default: 0, null: false

      t.timestamps
    end
  end
end
