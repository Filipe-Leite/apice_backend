class TopicsAuthor < ApplicationRecord
    belongs_to :topic
    belongs_to :author
end
