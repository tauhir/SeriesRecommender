require "application_system_test_case"

class SeriesListsTest < ApplicationSystemTestCase
  setup do
    @series_list = series_lists(:one)
  end

  test "visiting the index" do
    visit series_lists_url
    assert_selector "h1", text: "Series Lists"
  end

  test "creating a Series list" do
    visit series_lists_url
    click_on "New Series List"

    fill_in "Api id,", with: @series_list.api_id,
    fill_in "Name,language,origin country", with: @series_list.name,language,origin_country
    click_on "Create Series list"

    assert_text "Series list was successfully created"
    click_on "Back"
  end

  test "updating a Series list" do
    visit series_lists_url
    click_on "Edit", match: :first

    fill_in "Api id,", with: @series_list.api_id,
    fill_in "Name,language,origin country", with: @series_list.name,language,origin_country
    click_on "Update Series list"

    assert_text "Series list was successfully updated"
    click_on "Back"
  end

  test "destroying a Series list" do
    visit series_lists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Series list was successfully destroyed"
  end
end
