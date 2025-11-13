class AddCardTypeToCurrentCards < ActiveRecord::Migration[7.1]
  def change
    add_reference :current_cards, :card_type, null: true, foreign_key: true
  end
end