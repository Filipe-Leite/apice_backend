class DisciplinesAuthor < ApplicationRecord
    belongs_to :discipline
    belongs_to :author
end
