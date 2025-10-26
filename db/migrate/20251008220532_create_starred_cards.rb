class CreateStarredCards < ActiveRecord::Migration[7.1]
  def change
    create_table :starred_cards do |t|
      t.references :user, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
