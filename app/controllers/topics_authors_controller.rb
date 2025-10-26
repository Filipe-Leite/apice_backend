class TopicsAuthorsController < ApplicationController
  before_action :set_topics_author, only: %i[ show edit update destroy ]

  # GET /topics_authors or /topics_authors.json
  def index
    @topics_authors = TopicsAuthor.all
  end

  # GET /topics_authors/1 or /topics_authors/1.json
  def show
  end

  # GET /topics_authors/new
  def new
    @topics_author = TopicsAuthor.new
  end

  # GET /topics_authors/1/edit
  def edit
  end

  # POST /topics_authors or /topics_authors.json
  def create
    @topics_author = TopicsAuthor.new(topics_author_params)

    respond_to do |format|
      if @topics_author.save
        format.html { redirect_to @topics_author, notice: "Topics author was successfully created." }
        format.json { render :show, status: :created, location: @topics_author }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @topics_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics_authors/1 or /topics_authors/1.json
  def update
    respond_to do |format|
      if @topics_author.update(topics_author_params)
        format.html { redirect_to @topics_author, notice: "Topics author was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @topics_author }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @topics_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics_authors/1 or /topics_authors/1.json
  def destroy
    @topics_author.destroy!

    respond_to do |format|
      format.html { redirect_to topics_authors_path, notice: "Topics author was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topics_author
      @topics_author = TopicsAuthor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def topics_author_params
      params.require(:topics_author).permit(:topic_id, :author_id)
    end
end
