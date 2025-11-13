class CardType < ApplicationRecord
  has_many :current_cards
  has_many :cards

  validates :name, presence: true, uniqueness: true
end