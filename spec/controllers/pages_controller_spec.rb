require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "GET landing" do
    context "when admin" do
      it "redirects to admin" do
        login_admin

        get :landing

        expect(response).to redirect_to(admin_path)
      end
    end

    context "when user" do
      it "redirects to dashboard" do
        login_user

        get :landing

        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when guest" do
      it "renders the template" do
        get :landing

        expect(response).to render_template(:landing)
      end
    end
  end

  describe "GET dashboard" do
    context "when admin" do
      it "redirects to admin" do
        login_admin

        get :dashboard

        expect(response).to redirect_to(admin_path)
      end
    end

    context "when user" do
      it "renders the template" do
        login_user

        get :dashboard

        expect(response).to render_template(:dashboard)
      end
    end

    context "when guest" do
      it "redirects to login" do
        get :dashboard

        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "GET admin" do
    context "when admin" do
      it "renders the template" do
        login_admin

        get :admin

        expect(response).to render_template(:admin)
      end
    end

    context "when user" do
      it "raises routing error" do
        login_user

        expect {
          get :admin
        }.to raise_error(ActionController::RoutingError)
      end
    end

    context "when guest" do
      it "raises routing error" do
        expect {
          get :admin
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
