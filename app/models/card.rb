class Card < ApplicationRecord
    belongs_to :user
    belongs_to :source, optional: true
    belongs_to :card_type
end
