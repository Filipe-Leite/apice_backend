class SourcesController < ApplicationController

    def show
    @sources = Source.all
    
    if params[:letter].present?
      @sources = @sources.where(
        Source.arel_table[:title].matches("#{params[:letter]}%")
      )
    end
    
    @sources = @sources.paginate(page: params[:page], per_page: 10)

    render json: @sources, status: :ok
  end

  private

    def source_params
      params.require(:source).permit(:title)
    end
end
