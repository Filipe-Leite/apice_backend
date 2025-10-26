class CreateTopicsAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :topics_authors do |t|
      t.references :topic, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
