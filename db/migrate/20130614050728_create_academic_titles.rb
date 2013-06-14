class CreateAcademicTitles < ActiveRecord::Migration
  def change
    create_table :academic_titles do |t|
      t.string :name

      t.timestamps
    end
  end
end
