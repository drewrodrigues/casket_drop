require "rails_helper"

RSpec.describe "sessions/new", type: :view do
  it "has a form" do
    render

    expect(rendered).to have_selector("form")
  end

  it "has a email field" do
    render

    expect(rendered).to have_field("email")
  end

  it "has a password field" do
    render

    expect(rendered).to have_field("password")
  end

  it "has a submit button" do
    render

    expect(rendered).to have_button("Login")
  end

  it "shows errors" do
    @error = "Something goes here"

    render

    expect(rendered).to have_text("Something goes here")
  end
end
