class SearchController < ApplicationController
  before_action :authenticate_user!

  def index

    if params[:queryType] == 'discipline'

      @results = search_records(params[:queryType], params[:q], params[:page], params[:letter])

      render json: @results, status: :ok

    elsif params[:queryType] == 'topic'

      @results = search_records(params[:queryType], params[:q], params[:page], params[:letter])

      render json: @results, status: :ok
      
    elsif params[:queryType] == 'subtopic'

      @results = search_records(params[:queryType], params[:q], params[:page], params[:letter])

      render json: @results, status: :ok

    elsif params[:queryType] == 'author'
      
      @results = search_records(params[:queryType], params[:q], params[:page], params[:letter])

      render json: @results, status: :ok

    elsif params[:queryType] == 'source'
      
      @results = search_records(params[:queryType], params[:q], params[:page], params[:letter])

      render json: @results, status: :ok

    else
      render json: { errors: @results.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def search_records(type, query, page, letter)
    query = "#{query&.strip}%"

    letter = letter&.strip
    page = page.to_i

    case type
    when 'discipline'
      search_disciplines(query, page, letter)
    when 'topic'
      search_topic(query, page, letter)
    when 'subtopic'
      search_subtopic(query, page, letter)
    when 'author'
      search_author(query, page, letter)
    when 'source'
      search_source(query, page, letter)
    else
      []
    end
  end

  def search_disciplines(query, page, letter)
    disciplines = Discipline.all
    
    if letter.present?
      disciplines = disciplines.where("LOWER(name) ILIKE ?", "#{letter.downcase}%")
    end

    if query.present?
      lower_query = query.downcase
      disciplines = disciplines.where("LOWER(name) LIKE ?", "%#{lower_query}%")
    end
    
    disciplines.paginate(page: page, per_page: 10)
  end

  def search_topic(query, page, letter)
    topics = Topic.all
    
    if letter.present?
      topics = topics.where("LOWER(name) ILIKE ?", "#{letter.downcase}%")
    end

    if query.present?
      lower_query = query.downcase
      topics = topics.where("LOWER(name) LIKE ?", "%#{lower_query}%")
    end
    
    topics.paginate(page: page, per_page: 10)
  end

  def search_subtopic(query, page, letter)

    subtopics = Subtopic.all
    
    if letter.present?
      subtopics = subtopics.where("LOWER(name) ILIKE ?", "#{letter.downcase}%")
    end

    if query.present?
      lower_query = query.downcase
      subtopics = subtopics.where("LOWER(name) LIKE ?", "%#{lower_query}%")
    end
    
    subtopics.paginate(page: page, per_page: 10)
  end
  
  def search_author(query, page, letter)
    authors = Author.all
    
    if letter.present?
      authors = authors.where("LOWER(name) ILIKE ?", "#{letter.downcase}%")
    end

    if query.present?
      lower_query = query.downcase
      authors = authors.where("LOWER(name) LIKE ?", "%#{lower_query}%")
    end
    
    authors.paginate(page: page, per_page: 10)
  end

  def search_source(query, page, letter)
    sources = Source.all
    
    if letter.present?
      sources = sources.where("LOWER(title) ILIKE ?", "#{letter.downcase}%")
    end

    if query.present?
      lower_query = query.downcase
      sources = sources.where("LOWER(title) LIKE ?", "%#{lower_query}%")
    end
    
    sources.paginate(page: page, per_page: 10)
  end
end
