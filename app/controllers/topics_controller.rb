class TopicsController < ApplicationController

  def show

    @topics = Topic.all
    
    if params[:letter].present?
      @topics = @topics.where(
        Topic.arel_table[:name].matches("#{params[:letter]}%")
      )
    end

    if params[:discipline].present?
      @topics = @topics.joins(:topics_disciplines).where(topics_disciplines: { discipline_id: params[:discipline] })
    end

    @topics = @topics.paginate(page: params[:page], per_page: 200)

    render json: @topics, status: :ok
  end
  private

    def topic_params
      params.require(:topic).permit(:name)
    end
end
