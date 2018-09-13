Given /^I am on the get started page$/ do
  visit get_started_path
end

When /^I select my bottom fit$/ do
  select "Straight", from: "Bottom Fit"
end

When /^I select my top size$/ do
  select "MD", from: "Top Size"
end

When /^I select my waist size$/ do
  select "30", from: "Waist Size"
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
  expect(page).to have_content("Top size is not")
  expect(page).to have_content("Waist size is not")
end
