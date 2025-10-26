require "test_helper"

class TopicsDisciplinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @topics_discipline = topics_disciplines(:one)
  end

  test "should get index" do
    get topics_disciplines_url
    assert_response :success
  end

  test "should get new" do
    get new_topics_discipline_url
    assert_response :success
  end

  test "should create topics_discipline" do
    assert_difference("TopicsDiscipline.count") do
      post topics_disciplines_url, params: { topics_discipline: { discipline_id: @topics_discipline.discipline_id, topic_id: @topics_discipline.topic_id } }
    end

    assert_redirected_to topics_discipline_url(TopicsDiscipline.last)
  end

  test "should show topics_discipline" do
    get topics_discipline_url(@topics_discipline)
    assert_response :success
  end

  test "should get edit" do
    get edit_topics_discipline_url(@topics_discipline)
    assert_response :success
  end

  test "should update topics_discipline" do
    patch topics_discipline_url(@topics_discipline), params: { topics_discipline: { discipline_id: @topics_discipline.discipline_id, topic_id: @topics_discipline.topic_id } }
    assert_redirected_to topics_discipline_url(@topics_discipline)
  end

  test "should destroy topics_discipline" do
    assert_difference("TopicsDiscipline.count", -1) do
      delete topics_discipline_url(@topics_discipline)
    end

    assert_redirected_to topics_disciplines_url
  end
end
