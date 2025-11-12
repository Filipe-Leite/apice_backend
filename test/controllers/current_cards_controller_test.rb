require "test_helper"

class CurrentCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @current_card = current_cards(:one)
  end

  test "should get index" do
    get current_cards_url
    assert_response :success
  end

  test "should get new" do
    get new_current_card_url
    assert_response :success
  end

  test "should create current_card" do
    assert_difference("CurrentCard.count") do
      post current_cards_url, params: { current_card: { author_id: @current_card.author_id, city: @current_card.city, comment: @current_card.comment, edition: @current_card.edition, internet_access_date: @current_card.internet_access_date, internet_access_link: @current_card.internet_access_link, quote: @current_card.quote, source_id: @current_card.source_id, subtopic_id: @current_card.subtopic_id, user_id: @current_card.user_id, year: @current_card.year } }
    end

    assert_redirected_to current_card_url(CurrentCard.last)
  end

  test "should show current_card" do
    get current_card_url(@current_card)
    assert_response :success
  end

  test "should get edit" do
    get edit_current_card_url(@current_card)
    assert_response :success
  end

  test "should update current_card" do
    patch current_card_url(@current_card), params: { current_card: { author_id: @current_card.author_id, city: @current_card.city, comment: @current_card.comment, edition: @current_card.edition, internet_access_date: @current_card.internet_access_date, internet_access_link: @current_card.internet_access_link, quote: @current_card.quote, source_id: @current_card.source_id, subtopic_id: @current_card.subtopic_id, user_id: @current_card.user_id, year: @current_card.year } }
    assert_redirected_to current_card_url(@current_card)
  end

  test "should destroy current_card" do
    assert_difference("CurrentCard.count", -1) do
      delete current_card_url(@current_card)
    end

    assert_redirected_to current_cards_url
  end
end
