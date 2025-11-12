class Card < ApplicationRecord
    belongs_to :user
    belongs_to :source, optional: true
end
