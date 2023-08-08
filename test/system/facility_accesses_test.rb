require "application_system_test_case"

class FacilityAccessesTest < ApplicationSystemTestCase
  setup do
    @facility_access = facility_accesses(:one)
  end

  test "visiting the index" do
    visit facility_accesses_url
    assert_selector "h1", text: "Facility Accesses"
  end

  test "creating a Facility access" do
    visit facility_accesses_url
    click_on "New Facility Access"

    click_on "Create Facility access"

    assert_text "Facility access was successfully created"
    click_on "Back"
  end

  test "updating a Facility access" do
    visit facility_accesses_url
    click_on "Edit", match: :first

    click_on "Update Facility access"

    assert_text "Facility access was successfully updated"
    click_on "Back"
  end

  test "destroying a Facility access" do
    visit facility_accesses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Facility access was successfully destroyed"
  end
end
