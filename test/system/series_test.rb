require "application_system_test_case"

class SeriesTest < ApplicationSystemTestCase
  setup do
    @series = series(:one)
  end

  test "visiting the index" do
    visit series_url
    assert_selector "h1", text: "Series"
  end

  test "creating a Series" do
    visit series_url
    click_on "New Series"

    fill_in "Api id,", with: @series.api_id,
    fill_in "Name,language,origin country", with: @series.name,language,origin_country
    click_on "Create Series"

    assert_text "Series was successfully created"
    click_on "Back"
  end

  test "updating a Series" do
    visit series_url
    click_on "Edit", match: :first

    fill_in "Api id,", with: @series.api_id,
    fill_in "Name,language,origin country", with: @series.name,language,origin_country
    click_on "Update Series"

    assert_text "Series was successfully updated"
    click_on "Back"
  end

  test "destroying a Series" do
    visit series_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Series was successfully destroyed"
  end
end
