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

  it "displays full messages from error hash" do
    allow(@user).to receive_message_chain(:errors, :full_messages) { ["No email error", "Another error"] }

    render

    expect(rendered).to have_text("No email error")
  end

  context "when email attribute present on @user" do
    it "automatically inserts email" do
      allow(@user).to receive(:email) { "email@example.com" }

      render

      expect(rendered).to have_field("user_email", with: "email@example.com")
    end
  end
end
