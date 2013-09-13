class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password_digest
      t.references :group, index: true

      t.timestamps
    end
  end
end
