Given /^I am a registered admin$/ do
  @user = FactoryBot.create(:user, password: "password", admin: true)
end

Then /^I should see the admin page$/ do
  expect(page).to have_content("Admin Dashboard")
end
