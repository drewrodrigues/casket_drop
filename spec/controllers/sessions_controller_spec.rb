require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  let(:valid_attributes) do
    {
      email: "validemail@example.com",
      password: "password",
    }
  end

  describe "GET new" do
    context "when admin" do
      it "redirects to admin" do
        login_admin

        get :new

        expect(response).to redirect_to(admin_path)
      end
    end

    context "when user" do
      it "redirects to dashboard" do
        login_user

        get :new

        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when guest" do
      it "renders the template" do
        get :new

        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST create" do
    context "when admin" do
      it "redirects to admin" do
        login_admin

        post :create, params: valid_attributes

        expect(response).to redirect_to(admin_path)
      end
    end

    context "when user" do
      it "redirects to dashboard" do
        login_user

        post :create, params: valid_attributes

        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when guest" do
      context "is logging in as admin" do
        it "redirects to admin" do
          admin = create(:user, admin: true)

          post :create, params: { email: admin.email, password: "password" }

          expect(response).to redirect_to(admin_path)
        end
      end

      context "is logging in as user" do
        it "redirects to dashboard" do
          user = create(:user)

          post :create, params: { email: user.email, password: "password" }

          expect(response).to redirect_to(dashboard_path)
        end
      end
    end
  end

  describe "DELETE destroy" do
    context "when admin" do
      it "redirects to login" do
        login_admin

        delete :destroy

        expect(response).to redirect_to(login_path)
      end

      it "clears the session" do
        login_admin

        delete :destroy

        expect(controller.current_user).to eq(false)
      end
    end

    context "when user" do
      it "redirects to login" do
        login_user

        delete :destroy

        expect(response).to redirect_to(login_path)
      end

      it "clears the session" do
        login_user

        delete :destroy

        expect(controller.current_user).to eq(false)
      end
    end

    context "when guest" do
      it "redirects to login" do
        delete :destroy

        expect(response).to redirect_to(login_path)
      end
    end
  end
end
