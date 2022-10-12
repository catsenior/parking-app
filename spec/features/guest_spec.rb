require 'rails_helper'

feature "parking", type: :feature do
  scenario "guest parking" do
    # Step 1
    visit "/"

    expect(page).to have_content("一般費率")

    # Step 2
    click_button "開始計費"
    # Step 3:
    click_button "查看費用"
    # Step 4: 看到費用畫面
    expect(page).to have_content("¥2.00")
  end
end

feature "register and login", type: :feature do
  scenario "register" do
    visit "/users/sign_up"  # 瀏覽註冊頁面

    expect(page).to have_content("Sign up")

    within("#new_user") do  # 填表單
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "12345678"
      fill_in "Password confirmation", with: "12345678"
    end

    click_button "Sign up"

    # 檢查文字。這文字是 Devise 預設會放在 flash[:notice] 上的
    expect(page).to have_content("Welcome! You have signed up successfully.")

    # 檢查資料庫裡面最後一筆真的有剛剛填的資料
    user = User.last
    expect(user.email).to eq("test@example.com")
  end

  scenario "login and logout" do
    user = User.create!(email: "test@example.com", password: "12345678")
    visit "/users/sign_in"

    within("#new_user") do
      fill_in "Email", with: "test@example.com"
      fill_in "Password", with: "12345678"
    end
    click_button "Log in"
    expect(page).to have_content("Signed in successfully.")

    click_link "登出"
    expect(page).to have_content("Signed out successfully.")
  end
end
