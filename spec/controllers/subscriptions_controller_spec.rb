require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  describe "GET new" do
    context "when user" do
      it "renders the template" do
        login_user

        get :new

        expect(response).to render_template(:new)
      end

      it "assigns @user" do
        user = login_user

        get :new

        expect(assigns(:user)).to eq(user)
      end

      it "assigns @api_key" do
        login_user

        get :new

        expect(assigns(:api_key)).to_not be_nil
      end
    end

    context "when guest" do
      it "redirects to login" do
        get :new

        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "POST create" do
    context "when user" do
      it "redirects to dashboard" do
        card_token = StripeMock.generate_card_token
        login_user
        valid_attributes = {
          address: "Random Address",
          state: "CA",
          city: "Santa Rosa"
        }

        post :create, params: { user: valid_attributes, stripeToken: card_token  } 

        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when guest" do
      it "redirects to login" do
        post :create

        expect(response).to redirect_to(login_path)
      end
    end
  end
end
