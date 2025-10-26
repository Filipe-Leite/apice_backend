require "test_helper"

class SubtopicsTopicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subtopics_topic = subtopics_topics(:one)
  end

  test "should get index" do
    get subtopics_topics_url
    assert_response :success
  end

  test "should get new" do
    get new_subtopics_topic_url
    assert_response :success
  end

  test "should create subtopics_topic" do
    assert_difference("SubtopicsTopic.count") do
      post subtopics_topics_url, params: { subtopics_topic: { subtopic_id: @subtopics_topic.subtopic_id, topic_id: @subtopics_topic.topic_id } }
    end

    assert_redirected_to subtopics_topic_url(SubtopicsTopic.last)
  end

  test "should show subtopics_topic" do
    get subtopics_topic_url(@subtopics_topic)
    assert_response :success
  end

  test "should get edit" do
    get edit_subtopics_topic_url(@subtopics_topic)
    assert_response :success
  end

  test "should update subtopics_topic" do
    patch subtopics_topic_url(@subtopics_topic), params: { subtopics_topic: { subtopic_id: @subtopics_topic.subtopic_id, topic_id: @subtopics_topic.topic_id } }
    assert_redirected_to subtopics_topic_url(@subtopics_topic)
  end

  test "should destroy subtopics_topic" do
    assert_difference("SubtopicsTopic.count", -1) do
      delete subtopics_topic_url(@subtopics_topic)
    end

    assert_redirected_to subtopics_topics_url
  end
end
