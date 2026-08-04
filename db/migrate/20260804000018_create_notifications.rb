class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :message, null: false
      t.integer :notification_type, default: 0, null: false # 0: info, 1: success, 2: warning, 3: alert
      t.boolean :read, default: false, null: false
      t.string :action_url

      t.timestamps
    end

    add_index :notifications, [:user_id, :read]
  end
end
