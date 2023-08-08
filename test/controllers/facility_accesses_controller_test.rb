require "test_helper"

class FacilityAccessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @facility_access = facility_accesses(:one)
  end

  test "should get index" do
    get facility_accesses_url
    assert_response :success
  end

  test "should get new" do
    get new_facility_access_url
    assert_response :success
  end

  test "should create facility_access" do
    assert_difference('FacilityAccess.count') do
      post facility_accesses_url, params: { facility_access: {  } }
    end

    assert_redirected_to facility_access_url(FacilityAccess.last)
  end

  test "should show facility_access" do
    get facility_access_url(@facility_access)
    assert_response :success
  end

  test "should get edit" do
    get edit_facility_access_url(@facility_access)
    assert_response :success
  end

  test "should update facility_access" do
    patch facility_access_url(@facility_access), params: { facility_access: {  } }
    assert_redirected_to facility_access_url(@facility_access)
  end

  test "should destroy facility_access" do
    assert_difference('FacilityAccess.count', -1) do
      delete facility_access_url(@facility_access)
    end

    assert_redirected_to facility_accesses_url
  end
end
