class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.references :parent_company, foreign_key: { to_table: :companies }, null: true

      t.timestamps
    end

    add_index :companies, :code, unique: true
    add_reference :users, :company, foreign_key: true, null: true
  end
end
