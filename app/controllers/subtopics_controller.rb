class SubtopicsController < ApplicationController

  def show
    @subtopics = Subtopic.all
    
    if params[:discipline].present?
      @subtopics = @subtopics.joins(subtopics_topics: { topic: :topics_disciplines })
                            .where(topics_disciplines: { discipline_id: params[:discipline] })
    end
    
    if params[:letter].present? && params[:discipline].blank?
      @subtopics = @subtopics.where(
        Subtopic.arel_table[:name].matches("#{params[:letter]}%")
      )
    end

    @subtopics = @subtopics.paginate(page: params[:page], per_page: 10)

    render json: @subtopics, status: :ok
  end

  private

    def subtopic_params
      params.require(:subtopic).permit(:name)
    end
end
