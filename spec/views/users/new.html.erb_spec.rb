require "rails_helper"

RSpec.describe "users/new", type: :view do
  before do
    @user = User.new
  end

  it "has a form" do
    render

    expect(rendered).to have_selector("form")
  end

  it "has an email field" do
    render

    expect(rendered).to have_field("user_email")
  end

  it "has a password field" do
    render

    expect(rendered).to have_field("user_password")
  end

  it "has a submit button" do
    render

    expect(rendered).to have_button("Sign Up")
  end
end
