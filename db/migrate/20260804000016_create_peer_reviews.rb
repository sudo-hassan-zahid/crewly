class CreatePeerReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :peer_reviews do |t|
      t.references :reviewee, null: false, foreign_key: { to_table: :users }
      t.references :reviewer, null: false, foreign_key: { to_table: :users }
      t.string :relationship, null: false # e.g. peer, subordinate, manager
      t.text :strengths
      t.text :areas_for_improvement
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
