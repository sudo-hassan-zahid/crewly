class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :stripe_customer_id
      t.string :stripe_subscription_id
      t.integer :plan_tier, default: 0, null: false # 0: starter, 1: growth, 2: enterprise
      t.integer :status, default: 0, null: false # 0: active, 1: past_due, 2: canceled
      t.datetime :current_period_end

      t.timestamps
    end
  end
end
