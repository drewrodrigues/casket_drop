Given /^I am a registered user$/ do
  @user = FactoryBot.create(:user, password: "password")
end

When /^I am on the login page$/ do
  visit login_path
end

When /^I fill out the form with my email and password$/ do
  fill_in "Email", with: @user.email
  fill_in "Password", with: "password"
end

When /^I click login$/ do
  click_button "Login"
end

Then /^I should see the dashboard page$/ do
  expect(page).to have_content("Welcome to your dashboard, #{@user.first_name}!")
end

Then /^I should see the login page$/ do
  expect(page).to have_button("Login", count: 1)
end

Then /^I should see a login error$/ do
  expect(page).to have_content("There was a problem with your login.")
end
