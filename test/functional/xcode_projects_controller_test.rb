require 'test_helper'

class XcodeProjectsControllerTest < ActionController::TestCase
  setup do
    @xcode_project = xcode_projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:xcode_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create xcode_project" do
    assert_difference('XcodeProject.count') do
      post :create, xcode_project: {  }
    end

    assert_redirected_to xcode_project_path(assigns(:xcode_project))
  end

  test "should show xcode_project" do
    get :show, id: @xcode_project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @xcode_project
    assert_response :success
  end

  test "should update xcode_project" do
    put :update, id: @xcode_project, xcode_project: {  }
    assert_redirected_to xcode_project_path(assigns(:xcode_project))
  end

  test "should destroy xcode_project" do
    assert_difference('XcodeProject.count', -1) do
      delete :destroy, id: @xcode_project
    end

    assert_redirected_to xcode_projects_path
  end
end
