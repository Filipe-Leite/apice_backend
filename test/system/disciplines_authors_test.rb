require "application_system_test_case"

class DisciplinesAuthorsTest < ApplicationSystemTestCase
  setup do
    @disciplines_author = disciplines_authors(:one)
  end

  test "visiting the index" do
    visit disciplines_authors_url
    assert_selector "h1", text: "Disciplines authors"
  end

  test "should create disciplines author" do
    visit disciplines_authors_url
    click_on "New disciplines author"

    fill_in "Author", with: @disciplines_author.author_id
    fill_in "Discipline", with: @disciplines_author.discipline_id
    click_on "Create Disciplines author"

    assert_text "Disciplines author was successfully created"
    click_on "Back"
  end

  test "should update Disciplines author" do
    visit disciplines_author_url(@disciplines_author)
    click_on "Edit this disciplines author", match: :first

    fill_in "Author", with: @disciplines_author.author_id
    fill_in "Discipline", with: @disciplines_author.discipline_id
    click_on "Update Disciplines author"

    assert_text "Disciplines author was successfully updated"
    click_on "Back"
  end

  test "should destroy Disciplines author" do
    visit disciplines_author_url(@disciplines_author)
    click_on "Destroy this disciplines author", match: :first

    assert_text "Disciplines author was successfully destroyed"
  end
end
