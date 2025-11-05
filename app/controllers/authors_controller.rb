class AuthorsController < ApplicationController

  def show
    @authors = Author.all
    
    if params[:letter].present?
      @authors = @authors.where(
        Author.arel_table[:name].matches("#{params[:letter]}%")
      )
    end
    
    @authors = @authors.paginate(page: params[:page], per_page: 10)

    render json: @authors, status: :ok
  end

  private
    def author_params
      params.require(:author).permit(:name)
    end
end
