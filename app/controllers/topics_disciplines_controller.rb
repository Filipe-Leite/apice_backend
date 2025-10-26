class TopicsDisciplinesController < ApplicationController
  before_action :set_topics_discipline, only: %i[ show edit update destroy ]

  # GET /topics_disciplines or /topics_disciplines.json
  def index
    @topics_disciplines = TopicsDiscipline.all
  end

  # GET /topics_disciplines/1 or /topics_disciplines/1.json
  def show
  end

  # GET /topics_disciplines/new
  def new
    @topics_discipline = TopicsDiscipline.new
  end

  # GET /topics_disciplines/1/edit
  def edit
  end

  # POST /topics_disciplines or /topics_disciplines.json
  def create
    @topics_discipline = TopicsDiscipline.new(topics_discipline_params)

    respond_to do |format|
      if @topics_discipline.save
        format.html { redirect_to @topics_discipline, notice: "Topics discipline was successfully created." }
        format.json { render :show, status: :created, location: @topics_discipline }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topics_discipline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics_disciplines/1 or /topics_disciplines/1.json
  def update
    respond_to do |format|
      if @topics_discipline.update(topics_discipline_params)
        format.html { redirect_to @topics_discipline, notice: "Topics discipline was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @topics_discipline }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topics_discipline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics_disciplines/1 or /topics_disciplines/1.json
  def destroy
    @topics_discipline.destroy!

    respond_to do |format|
      format.html { redirect_to topics_disciplines_path, notice: "Topics discipline was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topics_discipline
      @topics_discipline = TopicsDiscipline.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def topics_discipline_params
      params.require(:topics_discipline).permit(:topic_id, :discipline_id)
    end
end
