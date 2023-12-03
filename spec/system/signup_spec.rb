require "rails_helper"

RSpec.describe "Signup" do
  before { visit root_path }

  it "validates password" do
    expect(page).to have_selector("#lowercase_validation.text-red-600")

    fill_in("user_password", with: "a")
    expect(page).to have_selector("#lowercase_validation.text-green-600")
  end

  it "allows for a successful signup" do
    fill_in("user_name", with: "Bruce Banner")
    fill_in("user_email", with: "hulk@avengers.net")
    fill_in("user_password", with: "THISisSUPERawesome!1$")
    click_on("Sign in")

    expect(page).to have_content("You successfully signed up")
  end
end
