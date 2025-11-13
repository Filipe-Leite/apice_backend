class AddCardTypeToCards < ActiveRecord::Migration[7.1]
  def change
    add_reference :cards, :card_type, null: true, foreign_key: true
  end
end