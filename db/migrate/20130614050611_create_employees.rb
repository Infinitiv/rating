class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.references :chair, index: true
      t.references :post, index: true
      t.references :degree, index: true
      t.references :academic_title, index: true
      t.boolean :head

      t.timestamps
    end
  end
end
