require "application_system_test_case"

class CardsTest < ApplicationSystemTestCase
  setup do
    @card = cards(:one)
  end

  test "visiting the index" do
    visit cards_url
    assert_selector "h1", text: "Cards"
  end

  test "should create card" do
    visit cards_url
    click_on "New card"

    fill_in "City", with: @card.city
    fill_in "Comment", with: @card.comment
    fill_in "Edition", with: @card.edition
    fill_in "Internet access date", with: @card.internet_access_date
    fill_in "Internet access link", with: @card.internet_access_link
    fill_in "Quote", with: @card.quote
    fill_in "Subject", with: @card.subject
    fill_in "Year", with: @card.year
    click_on "Create Card"

    assert_text "Card was successfully created"
    click_on "Back"
  end

  test "should update Card" do
    visit card_url(@card)
    click_on "Edit this card", match: :first

    fill_in "City", with: @card.city
    fill_in "Comment", with: @card.comment
    fill_in "Edition", with: @card.edition
    fill_in "Internet access date", with: @card.internet_access_date
    fill_in "Internet access link", with: @card.internet_access_link
    fill_in "Quote", with: @card.quote
    fill_in "Subject", with: @card.subject
    fill_in "Year", with: @card.year
    click_on "Update Card"

    assert_text "Card was successfully updated"
    click_on "Back"
  end

  test "should destroy Card" do
    visit card_url(@card)
    click_on "Destroy this card", match: :first

    assert_text "Card was successfully destroyed"
  end
end
