json.extract! topics_author, :id, :topic_id, :author_id, :created_at, :updated_at
json.url topics_author_url(topics_author, format: :json)
