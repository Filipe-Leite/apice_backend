class SubtopicsTopicsController < ApplicationController
  before_action :set_subtopics_topic, only: %i[ show edit update destroy ]

  # GET /subtopics_topics or /subtopics_topics.json
  def index
    @subtopics_topics = SubtopicsTopic.all
  end

  # GET /subtopics_topics/1 or /subtopics_topics/1.json
  def show
  end

  # GET /subtopics_topics/new
  def new
    @subtopics_topic = SubtopicsTopic.new
  end

  # GET /subtopics_topics/1/edit
  def edit
  end

  # POST /subtopics_topics or /subtopics_topics.json
  def create
    @subtopics_topic = SubtopicsTopic.new(subtopics_topic_params)

    respond_to do |format|
      if @subtopics_topic.save
        format.html { redirect_to @subtopics_topic, notice: "Subtopics topic was successfully created." }
        format.json { render :show, status: :created, location: @subtopics_topic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subtopics_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subtopics_topics/1 or /subtopics_topics/1.json
  def update
    respond_to do |format|
      if @subtopics_topic.update(subtopics_topic_params)
        format.html { redirect_to @subtopics_topic, notice: "Subtopics topic was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @subtopics_topic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subtopics_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subtopics_topics/1 or /subtopics_topics/1.json
  def destroy
    @subtopics_topic.destroy!

    respond_to do |format|
      format.html { redirect_to subtopics_topics_path, notice: "Subtopics topic was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subtopics_topic
      @subtopics_topic = SubtopicsTopic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def subtopics_topic_params
      params.require(:subtopics_topic).permit(:subtopic_id, :topic_id)
    end
end
