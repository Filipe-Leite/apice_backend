class CreateCardTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :card_types do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_index :card_types, :name, unique: true
  end
end