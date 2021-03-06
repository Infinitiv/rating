class ChairsController < ApplicationController
  before_action :set_chair, only: [:show, :edit, :update, :destroy]
  before_action :require_viewer
  before_action :require_editor, only: [:new, :edit, :create, :update, :destroy]

  # GET /chairs
  # GET /chairs.json
  def index
    @last_year = Point.maximum(:year)
    params[:filtered] ? @chairs = Chair.find_all_by_faculty_id(params[:filtered]) : @chairs = Chair.all
  end

  # GET /chairs/1
  # GET /chairs/1.json
  def show
    @last_year = Point.maximum(:year)
    @names = Point.attribute_names - ["id", "created_at", "updated_at", "year", "employee_id"] + ["inqualification_rating", "rating"]
  end

  # GET /chairs/new
  def new
    @chair = Chair.new
    @faculties = Faculty.all
  end

  # GET /chairs/1/edit
  def edit
    @faculties = Faculty.all
  end

  # POST /chairs
  # POST /chairs.json
  def create
    @chair = Chair.new(chair_params)

    respond_to do |format|
      if @chair.save
        format.html { redirect_to @chair, notice: 'Chair was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chair }
      else
        format.html { render action: 'new' }
        format.json { render json: @chair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chairs/1
  # PATCH/PUT /chairs/1.json
  def update
    respond_to do |format|
      if @chair.update(chair_params)
        format.html { redirect_to @chair, notice: 'Chair was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chairs/1
  # DELETE /chairs/1.json
  def destroy
    @chair.destroy
    respond_to do |format|
      format.html { redirect_to chairs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chair
      @chair = Chair.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chair_params
      params.require(:chair).permit(:name, :faculty_id, :clinic)
    end
end
