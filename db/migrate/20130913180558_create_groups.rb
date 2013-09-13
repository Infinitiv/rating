class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :administrator
      t.boolean :editor
      t.boolean :viewer

      t.timestamps
    end
  end
end
