class CreateTopicsDisciplines < ActiveRecord::Migration[7.1]
  def change
    create_table :topics_disciplines do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :discipline, null: false, foreign_key: true

      t.timestamps
    end
  end
end
