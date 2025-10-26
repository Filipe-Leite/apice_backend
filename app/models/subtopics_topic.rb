class SubtopicsTopic < ApplicationRecord
    belongs_to :topic
    belongs_to :subtopic
end
