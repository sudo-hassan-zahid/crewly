class CreateActivityLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :keystrokes_count, default: 0, null: false
      t.integer :mouse_clicks_count, default: 0, null: false
      t.string :active_window_title
      t.text :screenshot_url
      t.decimal :productivity_score, precision: 5, scale: 2, default: 0.0
      t.datetime :logged_at, null: false

      t.timestamps
    end

    add_index :activity_logs, [:user_id, :logged_at]
  end
end
