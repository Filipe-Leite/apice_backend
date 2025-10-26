class Topic < ApplicationRecord
    has_many :subtopics_topics
    has_many :topics_authors
end
