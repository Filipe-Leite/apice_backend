class Discipline < ApplicationRecord
    has_many :disciplines_authors
    has_many :topics_disciplines
end
