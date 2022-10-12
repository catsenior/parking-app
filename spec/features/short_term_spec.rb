require 'rails_helper'
feature "parking", type: :feature do
  scenario "short-term parking" do
    user = User.create!( email: "test@example.com", password: "12345678")
    sign_in(user)

    visit "/"
    choose "短期費率"

    click_button "開始計費"

    click_button "查看費用"

    expect(page).to have_content("¥2.00")
  end
end
