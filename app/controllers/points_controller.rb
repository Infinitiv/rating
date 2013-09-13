class PointsController < EmployeesController
  before_action :set_employee, only: [:index, :create, :new, :show, :edit, :destroy, :update]
  before_action :set_point, only: [:show, :edit, :update, :destroy]
  before_action :require_editor

  # GET /points
  # GET /points.json
  def index
    @points = @employee.points
  end

  # GET /points/1
  # GET /points/1.json
  def show
  end

  # GET /points/new
  def new
    @point = @employee.points.new
  end

  # GET /points/1/edit
  def edit
  end

  # POST /points
  # POST /points.json
  def create
    @point = @employee.points.new(point_params)

    respond_to do |format|
      if @point.save
        format.html { redirect_to @point.employee, notice: 'Point was successfully created.' }
        format.json { render action: 'show', status: :created, location: @point }
      else
        format.html { render action: 'new' }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /points/1
  # PATCH/PUT /points/1.json
  def update
    respond_to do |format|
      if @point.update(point_params)
        format.html { redirect_to @point, notice: 'Point was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.json
  def destroy
    @point.destroy
    respond_to do |format|
      format.html { redirect_to @employee }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_point
      @point = @employee.points.find(params[:id])
    end
    
    def set_employee
      @employee = Employee.find(params[:employee_id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def point_params
      params.require(:point).permit(:qualification, :learning, :science, :clinic, :social, :year, :employee_id)
    end
end
