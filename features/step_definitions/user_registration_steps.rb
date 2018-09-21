Given /^I am on the get started page$/ do
  visit get_started_path
end

When /^I select my favorite tops$/ do
  check "Crew Neck"
  check "Button Down"
end

When /^I select my favorite bottoms$/ do
  check "Shorts"
  check "Jeans"
end

When /^I select my bottom fit$/ do
  choose "Straight"
end

When /^I select my favorite colors$/ do
  check "Black"
  check "White"
end

When /^I select my top size$/ do
  choose "Medium"
end

When /^I select my waist size$/ do
  select "30", from: "user_waist_size"
end

When /^I fill in my first name$/ do
  fill_in "First Name", with: "Drew"
end

When /^I fill in my last name$/ do
  fill_in "Last Name", with: "Rodrigues"
end

When /^I fill in my email$/ do
  fill_in "Email", with: "example@example.com"
end

When /^I fill in my password$/ do
  fill_in "Password", with: "password"
end

When /^I click sign up$/ do
  click_button "Sign Up"
end

Then /^I should see the subscribe page$/ do
  expect(page).to have_button("Subscribe")
end

Then /^I should see the get started page$/ do
  expect(page).to have_content("Get Started")
end

Then /^I should see error messages$/ do
  expect(page).to have_content("Email is invalid")
  expect(page).to have_content("Email can't be blank")
  expect(page).to have_content("Password is too short")
  expect(page).to have_content("Password can't be blank")
  expect(page).to have_content("Bottom fit must be selected")
  expect(page).to have_content("Favorite bottoms must be selected")
  expect(page).to have_content("Favorite colors must be selected")
  expect(page).to have_content("Favorite tops must be selected")
  expect(page).to have_content("Top size must be selected")
  expect(page).to have_content("Waist size must be selected")
end
