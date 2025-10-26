require "application_system_test_case"

class SubtopicsTest < ApplicationSystemTestCase
  setup do
    @subtopic = subtopics(:one)
  end

  test "visiting the index" do
    visit subtopics_url
    assert_selector "h1", text: "Subtopics"
  end

  test "should create subtopic" do
    visit subtopics_url
    click_on "New subtopic"

    fill_in "Name", with: @subtopic.name
    click_on "Create Subtopic"

    assert_text "Subtopic was successfully created"
    click_on "Back"
  end

  test "should update Subtopic" do
    visit subtopic_url(@subtopic)
    click_on "Edit this subtopic", match: :first

    fill_in "Name", with: @subtopic.name
    click_on "Update Subtopic"

    assert_text "Subtopic was successfully updated"
    click_on "Back"
  end

  test "should destroy Subtopic" do
    visit subtopic_url(@subtopic)
    click_on "Destroy this subtopic", match: :first

    assert_text "Subtopic was successfully destroyed"
  end
end
