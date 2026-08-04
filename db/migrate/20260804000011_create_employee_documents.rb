class CreateEmployeeDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :employee_documents do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :document_type, default: 0, null: false # 0: identity_proof, 1: passport, 2: contract, 3: certificate, 4: other
      t.string :file_path
      t.text :description

      t.timestamps
    end
  end
end
