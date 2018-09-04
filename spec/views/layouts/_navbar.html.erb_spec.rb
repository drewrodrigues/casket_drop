require "rails_helper"

RSpec.describe "layouts/_navbar", type: :view do
  context "admin" do
    before do
      expect(view).to receive(:admin?) { true }
      expect(view).to receive(:current_user) { true }
    end

    it "has a 'Thread Box' link to admin" do
      render

      expect(rendered).to have_link("Thread Box", href: admin_path)
    end

    it "has a 'Admin' link" do
      render

      expect(rendered).to have_link("Admin", href: admin_path)
    end

    it "has a 'Logout' link" do
      render

      expect(rendered).to have_link("Logout", href: logout_path)
    end

    it "doesn't have a 'Dashboard' link" do
      render

      expect(rendered).to_not have_link("Dashboard")
    end
  end

  context "user" do
    before do
      expect(view).to receive(:user?) { true }
      expect(view).to receive(:current_user) { true }
    end

    it "has a 'Thread Box' link to dashboard" do
      render

      expect(rendered).to have_link("Thread Box", href: dashboard_path)
    end

    it "has a 'Dashboard' link" do
      render

      expect(rendered).to have_link("Dashboard", href: dashboard_path)
    end

    it "has a 'Logout' link" do
      render

      expect(rendered).to have_link("Logout", href: logout_path)
    end

    it "doesn't have a 'Admin' link" do
      render

      expect(rendered).to_not have_link("Admin")
    end
  end

  context "guest" do
    it "has a 'Thread Box' link to landing" do
      render

      expect(rendered).to have_link("Thread Box", href: root_path)
    end

    it "has a 'Login' link" do
      render

      expect(rendered).to have_link("Login", href: login_path)
    end

    it "has a 'Get Started' link" do
      render

      expect(rendered).to have_link("Get Started", href: get_started_path)
    end
  end
end
