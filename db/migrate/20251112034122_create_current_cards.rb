class CreateCurrentCards < ActiveRecord::Migration[7.1]
  def change
    create_table :current_cards do |t|
      t.string :quote
      t.string :comment
      t.string :edition
      t.string :city
      t.date :year
      t.date :internet_access_date
      t.string :internet_access_link
      t.references :user, null: false, foreign_key: true
      t.references :source, null: true, foreign_key: true
      t.references :author, null: true, foreign_key: true
      t.references :subtopic, null: true, foreign_key: true

      t.timestamps
    end
  end
end
