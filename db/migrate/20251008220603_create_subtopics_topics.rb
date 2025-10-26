class CreateSubtopicsTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :subtopics_topics do |t|
      t.references :subtopic, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end
  end
end
