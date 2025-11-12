class CurrentCard < ApplicationRecord
  belongs_to :user
  belongs_to :source, optional: true
  belongs_to :author, optional: true
  belongs_to :subtopic, optional: true
end
