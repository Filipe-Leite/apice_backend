class SubtopicsController < ApplicationController

  def show
    @subtopics = Subtopic.all
    
    if params[:letter].present?
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
