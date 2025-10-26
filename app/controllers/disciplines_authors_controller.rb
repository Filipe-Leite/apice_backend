class DisciplinesAuthorsController < ApplicationController
  before_action :set_disciplines_author, only: %i[ show edit update destroy ]

  # GET /disciplines_authors or /disciplines_authors.json
  def index
    @disciplines_authors = DisciplinesAuthor.all
  end

  # GET /disciplines_authors/1 or /disciplines_authors/1.json
  def show
  end

  # GET /disciplines_authors/new
  def new
    @disciplines_author = DisciplinesAuthor.new
  end

  # GET /disciplines_authors/1/edit
  def edit
  end

  # POST /disciplines_authors or /disciplines_authors.json
  def create
    @disciplines_author = DisciplinesAuthor.new(disciplines_author_params)

    respond_to do |format|
      if @disciplines_author.save
        format.html { redirect_to @disciplines_author, notice: "Disciplines author was successfully created." }
        format.json { render :show, status: :created, location: @disciplines_author }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @disciplines_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /disciplines_authors/1 or /disciplines_authors/1.json
  def update
    respond_to do |format|
      if @disciplines_author.update(disciplines_author_params)
        format.html { redirect_to @disciplines_author, notice: "Disciplines author was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @disciplines_author }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @disciplines_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /disciplines_authors/1 or /disciplines_authors/1.json
  def destroy
    @disciplines_author.destroy!

    respond_to do |format|
      format.html { redirect_to disciplines_authors_path, notice: "Disciplines author was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disciplines_author
      @disciplines_author = DisciplinesAuthor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def disciplines_author_params
      params.require(:disciplines_author).permit(:discipline_id, :author_id)
    end
end
