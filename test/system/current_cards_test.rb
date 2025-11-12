require "application_system_test_case"

class CurrentCardsTest < ApplicationSystemTestCase
  setup do
    @current_card = current_cards(:one)
  end

  test "visiting the index" do
    visit current_cards_url
    assert_selector "h1", text: "Current cards"
  end

  test "should create current card" do
    visit current_cards_url
    click_on "New current card"

    fill_in "Author", with: @current_card.author_id
    fill_in "City", with: @current_card.city
    fill_in "Comment", with: @current_card.comment
    fill_in "Edition", with: @current_card.edition
    fill_in "Internet access date", with: @current_card.internet_access_date
    fill_in "Internet access link", with: @current_card.internet_access_link
    fill_in "Quote", with: @current_card.quote
    fill_in "Source", with: @current_card.source_id
    fill_in "Subtopic", with: @current_card.subtopic_id
    fill_in "User", with: @current_card.user_id
    fill_in "Year", with: @current_card.year
    click_on "Create Current card"

    assert_text "Current card was successfully created"
    click_on "Back"
  end

  test "should update Current card" do
    visit current_card_url(@current_card)
    click_on "Edit this current card", match: :first

    fill_in "Author", with: @current_card.author_id
    fill_in "City", with: @current_card.city
    fill_in "Comment", with: @current_card.comment
    fill_in "Edition", with: @current_card.edition
    fill_in "Internet access date", with: @current_card.internet_access_date
    fill_in "Internet access link", with: @current_card.internet_access_link
    fill_in "Quote", with: @current_card.quote
    fill_in "Source", with: @current_card.source_id
    fill_in "Subtopic", with: @current_card.subtopic_id
    fill_in "User", with: @current_card.user_id
    fill_in "Year", with: @current_card.year
    click_on "Update Current card"

    assert_text "Current card was successfully updated"
    click_on "Back"
  end

  test "should destroy Current card" do
    visit current_card_url(@current_card)
    click_on "Destroy this current card", match: :first

    assert_text "Current card was successfully destroyed"
  end
end
