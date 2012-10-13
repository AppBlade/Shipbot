require 'test_helper'

class DeveloperCertificatesControllerTest < ActionController::TestCase
  setup do
    @developer_certificate = developer_certificates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:developer_certificates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create developer_certificate" do
    assert_difference('DeveloperCertificate.count') do
      post :create, developer_certificate: {  }
    end

    assert_redirected_to developer_certificate_path(assigns(:developer_certificate))
  end

  test "should show developer_certificate" do
    get :show, id: @developer_certificate
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @developer_certificate
    assert_response :success
  end

  test "should update developer_certificate" do
    put :update, id: @developer_certificate, developer_certificate: {  }
    assert_redirected_to developer_certificate_path(assigns(:developer_certificate))
  end

  test "should destroy developer_certificate" do
    assert_difference('DeveloperCertificate.count', -1) do
      delete :destroy, id: @developer_certificate
    end

    assert_redirected_to developer_certificates_path
  end
end
