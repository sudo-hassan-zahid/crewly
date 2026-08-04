class CreatePerformanceReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :performance_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reviewer, null: false, foreign_key: { to_table: :users }
      t.string :review_period, null: false # e.g. "Q1 2026", "Annual 2026"
      t.integer :rating, null: false # 1 to 5 scale
      t.text :self_assessment
      t.text :reviewer_feedback
      t.integer :status, default: 0, null: false # 0: draft, 1: submitted, 2: completed

      t.timestamps
    end
  end
end
