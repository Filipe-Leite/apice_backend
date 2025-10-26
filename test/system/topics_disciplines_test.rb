require "application_system_test_case"

class TopicsDisciplinesTest < ApplicationSystemTestCase
  setup do
    @topics_discipline = topics_disciplines(:one)
  end

  test "visiting the index" do
    visit topics_disciplines_url
    assert_selector "h1", text: "Topics disciplines"
  end

  test "should create topics discipline" do
    visit topics_disciplines_url
    click_on "New topics discipline"

    fill_in "Discipline", with: @topics_discipline.discipline_id
    fill_in "Topic", with: @topics_discipline.topic_id
    click_on "Create Topics discipline"

    assert_text "Topics discipline was successfully created"
    click_on "Back"
  end

  test "should update Topics discipline" do
    visit topics_discipline_url(@topics_discipline)
    click_on "Edit this topics discipline", match: :first

    fill_in "Discipline", with: @topics_discipline.discipline_id
    fill_in "Topic", with: @topics_discipline.topic_id
    click_on "Update Topics discipline"

    assert_text "Topics discipline was successfully updated"
    click_on "Back"
  end

  test "should destroy Topics discipline" do
    visit topics_discipline_url(@topics_discipline)
    click_on "Destroy this topics discipline", match: :first

    assert_text "Topics discipline was successfully destroyed"
  end
end
