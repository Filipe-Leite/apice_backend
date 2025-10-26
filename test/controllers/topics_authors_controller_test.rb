require "test_helper"

class TopicsAuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @topics_author = topics_authors(:one)
  end

  test "should get index" do
    get topics_authors_url
    assert_response :success
  end

  test "should get new" do
    get new_topics_author_url
    assert_response :success
  end

  test "should create topics_author" do
    assert_difference("TopicsAuthor.count") do
      post topics_authors_url, params: { topics_author: { author_id: @topics_author.author_id, topic_id: @topics_author.topic_id } }
    end

    assert_redirected_to topics_author_url(TopicsAuthor.last)
  end

  test "should show topics_author" do
    get topics_author_url(@topics_author)
    assert_response :success
  end

  test "should get edit" do
    get edit_topics_author_url(@topics_author)
    assert_response :success
  end

  test "should update topics_author" do
    patch topics_author_url(@topics_author), params: { topics_author: { author_id: @topics_author.author_id, topic_id: @topics_author.topic_id } }
    assert_redirected_to topics_author_url(@topics_author)
  end

  test "should destroy topics_author" do
    assert_difference("TopicsAuthor.count", -1) do
      delete topics_author_url(@topics_author)
    end

    assert_redirected_to topics_authors_url
  end
end
