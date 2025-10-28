class DisciplinesController < ApplicationController

  def index

    @disciplines = Discipline.all.paginate(page: params[:page], per_page: 10)

    render json: @disciplines, status: :ok
  end

  def show

    @disciplines = Discipline.all
    
    if params[:letter].present?
      @disciplines = @disciplines.where(
        Discipline.arel_table[:name].matches("#{params[:letter]}%")
      )
    end
    
    @disciplines = @disciplines.paginate(page: params[:page], per_page: 10)

    render json: @disciplines, status: :ok
  end

  def new
    @discipline = Discipline.new
  end

  def edit
  end

  def create
    @discipline = Discipline.new(discipline_params)

    respond_to do |format|
      if @discipline.save
        format.html { redirect_to @discipline, notice: "Discipline was successfully created." }
        format.json { render :show, status: :created, location: @discipline }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @discipline.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @discipline.update(discipline_params)
        format.html { redirect_to @discipline, notice: "Discipline was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @discipline }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @discipline.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @discipline.destroy!

    respond_to do |format|
      format.html { redirect_to disciplines_path, notice: "Discipline was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_discipline
      @discipline = Discipline.find(params[:id])
    end

    def discipline_params
      params.require(:discipline).permit(:name)
    end
end
