require "application_system_test_case"

class TopicsAuthorsTest < ApplicationSystemTestCase
  setup do
    @topics_author = topics_authors(:one)
  end

  test "visiting the index" do
    visit topics_authors_url
    assert_selector "h1", text: "Topics authors"
  end

  test "should create topics author" do
    visit topics_authors_url
    click_on "New topics author"

    fill_in "Author", with: @topics_author.author_id
    fill_in "Topic", with: @topics_author.topic_id
    click_on "Create Topics author"

    assert_text "Topics author was successfully created"
    click_on "Back"
  end

  test "should update Topics author" do
    visit topics_author_url(@topics_author)
    click_on "Edit this topics author", match: :first

    fill_in "Author", with: @topics_author.author_id
    fill_in "Topic", with: @topics_author.topic_id
    click_on "Update Topics author"

    assert_text "Topics author was successfully updated"
    click_on "Back"
  end

  test "should destroy Topics author" do
    visit topics_author_url(@topics_author)
    click_on "Destroy this topics author", match: :first

    assert_text "Topics author was successfully destroyed"
  end
end
