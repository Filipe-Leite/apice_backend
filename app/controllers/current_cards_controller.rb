class CurrentCardsController < ApplicationController
  before_action :set_current_card, only: %i[ show edit destroy ]
  before_action :authenticate_user!

  def index
    @current_cards = CurrentCard.all
  end
  def show
  end

  def new
    @current_card = CurrentCard.new
  end

  def edit
  end

  def create

    @current_card = CurrentCard.new(card_params = current_card_params.merge(user_id: current_user.id))

    if @current_card.save
      render json: @current_card, status: :created
    else
      render json: { errors: @current_card.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def destroy
    @current_card.destroy!

    respond_to do |format|
      format.html { redirect_to current_cards_path, notice: "Current card was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_current_card
      @current_card = CurrentCard.find(params[:id])
    end

    def current_card_params
      params.require(:current_card).permit(:quote, :comment, :edition, :city, :year, :internet_access_date, :internet_access_link, :user_id, :source_id, :author_id, :subtopic_id)
    end
end
