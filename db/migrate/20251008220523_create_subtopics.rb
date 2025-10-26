class CreateSubtopics < ActiveRecord::Migration[7.1]
  def change
    create_table :subtopics do |t|
      t.string :name

      t.timestamps
    end
  end
end
