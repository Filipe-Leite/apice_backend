class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :subject
      t.string :quote
      t.string :comment
      t.string :edition
      t.string :city
      t.date :year
      t.date :internet_access_date
      t.string :internet_access_link
      t.references :user, null: false, foreign_key: true
      t.references :resource, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
