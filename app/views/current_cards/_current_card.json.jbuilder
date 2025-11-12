json.extract! current_card, :id, :quote, :comment, :edition, :city, :year, :internet_access_date, :internet_access_link, :user_id, :source_id, :author_id, :subtopic_id, :created_at, :updated_at
json.url current_card_url(current_card, format: :json)
