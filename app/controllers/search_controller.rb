class SearchController < ApplicationController
  before_action :authenticate_user!

  def index

    if params[:queryType] == 'discipline'
      @results = search_records(params[:queryType], params[:q], params[:page], params[:letter])

      render json: @results, status: :ok

    elsif params[:queryType] == 'groups'
      @results = search_records(params[:queryType], params[:q], params[:page])

        render json: @results.as_json(include: 
                                      { creator:  { include: { user_more_info: { methods: :avatar_url } } },
                                        group_musical_genres: { include: { 
                                                                          music_genre: {}
                                      }}}, 
                                      user: { include: { user_more_info: { methods: :avatar_url } } } ), status: :ok
      
    elsif params[:queryType] == 'projects'
      @results = search_records(params[:queryType], params[:q], params[:page])
      
      results =  @results.map do |project|
          {
            project: project,
            master_files: project.files_signed_urls_project
          }
      end

      render json: {
                    results: results
                   }, include: { user: {
                                only: [ :id, :nickname],
                                include: {
                                  user_more_info: {}
                                }} }, status: :ok
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
      search_topic(query, page)
    when 'subtopic'
      search_subtopic(query, page)
    when 'author'
      search_author(query, page)
    when 'source'
      search_source(query, page)
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

  def search_topic(query, page)
    lower_query = "#{query.downcase}"
    
    topic_found = Topic.where("LOWER(groups.name) LIKE :query", 
                                query: lower_query)
                        .paginate(page: page, per_page: 10)
    
    topic_found
  end

  def search_subtopic(query, page)

    lower_query = "#{query.strip.downcase}"

    @Projects = Project.joins(user: :user_more_info)
                      .joins(user: { user_musical_genres: :music_genre })
                      .where(
                        "LOWER(users.nickname) LIKE :query OR 
                        LOWER(user_more_infos.name) LIKE :query OR
                        LOWER(user_more_infos.last_name) LIKE :query OR
                        LOWER(user_more_infos.nickname) LIKE :query OR
                        LOWER(user_more_infos.email) LIKE :query OR
                        LOWER(user_more_infos.phone_number) LIKE :query OR
                        LOWER(user_more_infos.website) LIKE :query OR
                        LOWER(user_more_infos.city) LIKE :query OR
                        LOWER(user_more_infos.state) LIKE :query OR
                        LOWER(user_more_infos.country) LIKE :query OR
                        LOWER(user_more_infos.about) LIKE :query OR
                        LOWER(projects.title) LIKE :query OR 
                        LOWER(projects.description) LIKE :query OR
                        LOWER(music_genres.description) LIKE :query",
                        query: "%#{lower_query.downcase}%"
                      )
                      .distinct
                      .paginate(page: page, per_page: 10)

    route_user_as_contributor = @Projects.joins(:contributors)
                                         .where('projects.user_id = ? AND 
                                                   contributors.user_id = ? OR 
                                                   projects.privacity = ?',
                                                   current_user.id,current_user.id, 0)
  end
  
  def search_author(query, page)

    lower_query = "#{query.strip.downcase}"

    @Projects = Project.joins(user: :user_more_info)
                      .joins(user: { user_musical_genres: :music_genre })
                      .where(
                        "LOWER(users.nickname) LIKE :query OR 
                        LOWER(user_more_infos.name) LIKE :query OR
                        LOWER(user_more_infos.last_name) LIKE :query OR
                        LOWER(user_more_infos.nickname) LIKE :query OR
                        LOWER(user_more_infos.email) LIKE :query OR
                        LOWER(user_more_infos.phone_number) LIKE :query OR
                        LOWER(user_more_infos.website) LIKE :query OR
                        LOWER(user_more_infos.city) LIKE :query OR
                        LOWER(user_more_infos.state) LIKE :query OR
                        LOWER(user_more_infos.country) LIKE :query OR
                        LOWER(user_more_infos.about) LIKE :query OR
                        LOWER(projects.title) LIKE :query OR 
                        LOWER(projects.description) LIKE :query OR
                        LOWER(music_genres.description) LIKE :query",
                        query: "%#{lower_query.downcase}%"
                      )
                      .distinct
                      .paginate(page: page, per_page: 10)

    route_user_as_contributor = @Projects.joins(:contributors)
                                         .where('projects.user_id = ? AND 
                                                   contributors.user_id = ? OR 
                                                   projects.privacity = ?',
                                                   current_user.id,current_user.id, 0)
  end

  def search_source(query, page)

    lower_query = "#{query.strip.downcase}"

    @Projects = Project.joins(user: :user_more_info)
                      .joins(user: { user_musical_genres: :music_genre })
                      .where(
                        "LOWER(users.nickname) LIKE :query OR 
                        LOWER(user_more_infos.name) LIKE :query OR
                        LOWER(user_more_infos.last_name) LIKE :query OR
                        LOWER(user_more_infos.nickname) LIKE :query OR
                        LOWER(user_more_infos.email) LIKE :query OR
                        LOWER(user_more_infos.phone_number) LIKE :query OR
                        LOWER(user_more_infos.website) LIKE :query OR
                        LOWER(user_more_infos.city) LIKE :query OR
                        LOWER(user_more_infos.state) LIKE :query OR
                        LOWER(user_more_infos.country) LIKE :query OR
                        LOWER(user_more_infos.about) LIKE :query OR
                        LOWER(projects.title) LIKE :query OR 
                        LOWER(projects.description) LIKE :query OR
                        LOWER(music_genres.description) LIKE :query",
                        query: "%#{lower_query.downcase}%"
                      )
                      .distinct
                      .paginate(page: page, per_page: 10)

    route_user_as_contributor = @Projects.joins(:contributors)
                                         .where('projects.user_id = ? AND 
                                                   contributors.user_id = ? OR 
                                                   projects.privacity = ?',
                                                   current_user.id,current_user.id, 0)
  end
end
