require 'test_helper'

class ProvisioningProfilesControllerTest < ActionController::TestCase
  setup do
    @provisioning_profile = provisioning_profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:provisioning_profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create provisioning_profile" do
    assert_difference('ProvisioningProfile.count') do
      post :create, provisioning_profile: { application_identifier: @provisioning_profile.application_identifier, application_identifier_prefix: @provisioning_profile.application_identifier_prefix, enterprise: @provisioning_profile.enterprise, expires_at: @provisioning_profile.expires_at, issued_at: @provisioning_profile.issued_at, mobileprovision: @provisioning_profile.mobileprovision, name: @provisioning_profile.name, provisioned_devices_count: @provisioning_profile.provisioned_devices_count, team_identifier: @provisioning_profile.team_identifier, uuid: @provisioning_profile.uuid }
    end

    assert_redirected_to provisioning_profile_path(assigns(:provisioning_profile))
  end

  test "should show provisioning_profile" do
    get :show, id: @provisioning_profile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @provisioning_profile
    assert_response :success
  end

  test "should update provisioning_profile" do
    put :update, id: @provisioning_profile, provisioning_profile: { application_identifier: @provisioning_profile.application_identifier, application_identifier_prefix: @provisioning_profile.application_identifier_prefix, enterprise: @provisioning_profile.enterprise, expires_at: @provisioning_profile.expires_at, issued_at: @provisioning_profile.issued_at, mobileprovision: @provisioning_profile.mobileprovision, name: @provisioning_profile.name, provisioned_devices_count: @provisioning_profile.provisioned_devices_count, team_identifier: @provisioning_profile.team_identifier, uuid: @provisioning_profile.uuid }
    assert_redirected_to provisioning_profile_path(assigns(:provisioning_profile))
  end

  test "should destroy provisioning_profile" do
    assert_difference('ProvisioningProfile.count', -1) do
      delete :destroy, id: @provisioning_profile
    end

    assert_redirected_to provisioning_profiles_path
  end
end
