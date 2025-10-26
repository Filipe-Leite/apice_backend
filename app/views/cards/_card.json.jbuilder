json.extract! card, :id, :subject, :quote, :comment, :edition, :city, :year, :internet_access_date, :internet_access_link, :created_at, :updated_at
json.url card_url(card, format: :json)
