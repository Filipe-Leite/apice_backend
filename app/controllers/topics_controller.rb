class TopicsController < ApplicationController

  def show

    @topics = Topic.all

    p "afafadf >>>>>>>> #{params}"
    p "afafadf >>>>>>>> #{params}"
    p "afafadf >>>>>>>> #{params}"
    p "afafadf >>>>>>>> #{params}"
    p "afafadf >>>>>>>> #{params}"
    p "afafadf >>>>>>>> #{params}"
    p "afafadf >>>>>>>> #{params}"
    p "afafadf >>>>>>>> #{params}"
    p "afafadf >>>>>>>> #{params}"
    p "afafadf >>>>>>>> #{params}"
    p "afafadf >>>>>>>> #{params}"
    
    if params[:discipline].present? 
      @topics = @topics.joins(:topics_disciplines).where(topics_disciplines: { discipline_id: params[:discipline] })
    end

    if params[:letter].present? && params[:discipline].blank
      @topics = @topics.where(
        Topic.arel_table[:name].matches("#{params[:letter]}%")
      )
    end

    @topics = @topics.paginate(page: params[:page], per_page: 10)

    render json: @topics, status: :ok
  end
  private

    def topic_params
      params.require(:topic).permit(:name)
    end
end
