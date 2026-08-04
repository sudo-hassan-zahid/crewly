class CreateDesignations < ActiveRecord::Migration[7.1]
  def change
    create_table :designations do |t|
      t.string :title, null: false
      t.string :code, null: false
      t.references :department, foreign_key: true, null: true
      t.text :description

      t.timestamps
    end
    add_index :designations, :code, unique: true
  end
end
