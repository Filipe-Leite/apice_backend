require "test_helper"

class DisciplinesAuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @disciplines_author = disciplines_authors(:one)
  end

  test "should get index" do
    get disciplines_authors_url
    assert_response :success
  end

  test "should get new" do
    get new_disciplines_author_url
    assert_response :success
  end

  test "should create disciplines_author" do
    assert_difference("DisciplinesAuthor.count") do
      post disciplines_authors_url, params: { disciplines_author: { author_id: @disciplines_author.author_id, discipline_id: @disciplines_author.discipline_id } }
    end

    assert_redirected_to disciplines_author_url(DisciplinesAuthor.last)
  end

  test "should show disciplines_author" do
    get disciplines_author_url(@disciplines_author)
    assert_response :success
  end

  test "should get edit" do
    get edit_disciplines_author_url(@disciplines_author)
    assert_response :success
  end

  test "should update disciplines_author" do
    patch disciplines_author_url(@disciplines_author), params: { disciplines_author: { author_id: @disciplines_author.author_id, discipline_id: @disciplines_author.discipline_id } }
    assert_redirected_to disciplines_author_url(@disciplines_author)
  end

  test "should destroy disciplines_author" do
    assert_difference("DisciplinesAuthor.count", -1) do
      delete disciplines_author_url(@disciplines_author)
    end

    assert_redirected_to disciplines_authors_url
  end
end
