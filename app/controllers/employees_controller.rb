class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :set_last_year, only: [:index, :show]
  before_action :require_viewer
  before_action :require_editor, only: [:new, :edit, :create, :update, :destroy]

  # GET /employees
  # GET /employees.json
  def index
    params[:filtered] ? @employees = Employee.find_all_by_post_id(params[:filtered], :include => [:points, :post, :chair]) : @employees = Employee.all(:include => [:points, :post, :chair])
    respond_to do |format|
      format.html
      format.xls
    end
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
    @points = @employee.points.order(:year)
    @point = @employee.points.new
    @graph_points = graph_points(@points)
    @prev_employee = Employee.find_by_id(@employee.id - 1)
    @next_employee = Employee.find_by_id(@employee.id + 1)
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @chairs = Chair.all.order(:name)
    @posts = Post.all.order(:name)
    @degrees = Degree.all.order(:name)
    @academic_titles = AcademicTitle.all.order(:name)
  end

  # GET /employees/1/edit
  def edit
    @chairs = Chair.all.order(:name)
    @posts = Post.all.order(:name)
    @degrees = Degree.all.order(:name)
    @academic_titles = AcademicTitle.all.order(:name)
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render action: 'show', status: :created, location: @employee }
      else
        format.html { render action: 'new' }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end

  def import
    Employee.import(params[:file])
    redirect_to employees_url, notice: "Employees imported."
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:first_name, :middle_name, :last_name, :chair_id, :post_id, :degree_id, :academic_title_id, :head)
    end
    
    def set_last_year
      @last_year = Point.maximum(:year)
    end

    def graph_points(points)
      graph_points = []
      h = {}
      points.select("year, qualification, learning, science, clinic, social").each do |point|
        point.attributes.each do |key, value|
          h[key] ||= [] unless key == "id"
          h[key] += [value] unless key == "id"
        end
      end
      points.each do |point|
        h["Inqualification rating"] ||= [] unless point.id == nil
        h["Inqualification rating"] += [point.inqualification_rating] unless point.id == nil
        h["Rating"] ||= [] unless point.id == nil
        h["Rating"] += [point.rating] unless point.id == nil
      end
      h.each do |key, value|
        graph_points << [key.humanize] + value
      end
      graph_points
    end  
end
