require "application_system_test_case"

class SubtopicsTopicsTest < ApplicationSystemTestCase
  setup do
    @subtopics_topic = subtopics_topics(:one)
  end

  test "visiting the index" do
    visit subtopics_topics_url
    assert_selector "h1", text: "Subtopics topics"
  end

  test "should create subtopics topic" do
    visit subtopics_topics_url
    click_on "New subtopics topic"

    fill_in "Subtopic", with: @subtopics_topic.subtopic_id
    fill_in "Topic", with: @subtopics_topic.topic_id
    click_on "Create Subtopics topic"

    assert_text "Subtopics topic was successfully created"
    click_on "Back"
  end

  test "should update Subtopics topic" do
    visit subtopics_topic_url(@subtopics_topic)
    click_on "Edit this subtopics topic", match: :first

    fill_in "Subtopic", with: @subtopics_topic.subtopic_id
    fill_in "Topic", with: @subtopics_topic.topic_id
    click_on "Update Subtopics topic"

    assert_text "Subtopics topic was successfully updated"
    click_on "Back"
  end

  test "should destroy Subtopics topic" do
    visit subtopics_topic_url(@subtopics_topic)
    click_on "Destroy this subtopics topic", match: :first

    assert_text "Subtopics topic was successfully destroyed"
  end
end
