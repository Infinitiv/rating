class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.float :qualification
      t.float :learning
      t.float :science
      t.float :clinic
      t.float :social
      t.integer :year
      t.references :employee, index: true

      t.timestamps
    end
  end
end
