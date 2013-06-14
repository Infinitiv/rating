require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post :create, employee: { academic_title_id: @employee.academic_title_id, chair_id: @employee.chair_id, degree_id: @employee.degree_id, first_name: @employee.first_name, head: @employee.head, last_name: @employee.last_name, middle_name: @employee.middle_name, post_id: @employee.post_id }
    end

    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should show employee" do
    get :show, id: @employee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employee
    assert_response :success
  end

  test "should update employee" do
    patch :update, id: @employee, employee: { academic_title_id: @employee.academic_title_id, chair_id: @employee.chair_id, degree_id: @employee.degree_id, first_name: @employee.first_name, head: @employee.head, last_name: @employee.last_name, middle_name: @employee.middle_name, post_id: @employee.post_id }
    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete :destroy, id: @employee
    end

    assert_redirected_to employees_path
  end
end
