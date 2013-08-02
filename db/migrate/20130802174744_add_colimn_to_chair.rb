class AddColimnToChair < ActiveRecord::Migration
  def change
    add_column :chairs, :clinic, :boolean
  end
end
