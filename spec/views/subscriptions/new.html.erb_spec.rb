require "rails_helper"

RSpec.describe "subscriptions/new", type: :view do
  before do
    @user = User.new
  end

  it "has a form" do
    render

    expect(rendered).to have_selector("form")
  end

  it "has a address field" do
    render

    expect(rendered).to have_field("Address")
  end

  it "has a city field" do
    render

    expect(rendered).to have_field("City")
  end

  it "has a state field" do
    render

    expect(rendered).to have_field("State")
  end
end
