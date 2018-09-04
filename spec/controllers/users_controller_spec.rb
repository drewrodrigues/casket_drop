require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) do
    {
      email: "valid_email@example.com",
      password: "password",
      admin: false,
    }
  end

  describe "GET index" do
    context "when admin" do
      it "renders the template" do
        login_admin

        get :index

        expect(response).to render_template(:index)
      end

      it "assigns @users" do
        login_admin

        get :index

        expect(assigns(:users)).to eq(User.all)
      end
    end

    context "when user" do
      it "raises routing error" do
        login_user

        expect do
          get :index
        end.to raise_error ActionController::RoutingError
      end
    end

    context "when guest" do
      it "raises routing error" do
        expect do
          get :index
        end.to raise_error ActionController::RoutingError
      end
    end
  end

  describe "GET show" do
    context "when admin" do
      it "renders the template" do
        admin = login_admin

        get :show, params: { id: admin }

        expect(response).to render_template(:show)
      end

      it "assigns @user" do
        admin = login_admin

        get :show, params: { id: admin }

        expect(assigns(:user)).to eq(admin)
      end
    end

    context "when user" do
      context "and their id is passed" do
        it "renders the template" do
          user = login_admin

          get :show, params: { id: user }

          expect(response).to render_template(:show)
        end

        it "assigns @user" do
          user = login_user

          get :show, params: { id: user }

          expect(assigns(:user)).to eq(user)
        end
      end

      context "and another user id is passed" do
        it "raises a routing error" do
          login_user

          expect do
            get :show, params: { id: 200 }
          end.to raise_error(ActionController::RoutingError)
        end
      end
    end

    context "when guest" do
      it "redirects to login" do
        get :show, params: { id: 5 }

        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET new" do
    context "when admin" do
      it "redirects to admin" do
        login_admin

        get :new

        expect(response).to redirect_to admin_path
      end
    end

    context "when user" do
      it "redirects to dashboard" do
        login_user

        get :new

        expect(response).to redirect_to dashboard_path
      end
    end

    context "when guest" do
      it "renders the template" do
        get :new

        expect(response).to render_template :new
      end

      it "assigns @user" do
        fake_user = User.new
        allow(User).to receive(:new) { fake_user }

        get :new

        expect(assigns(:user)).to eq fake_user
      end
    end
  end

  describe "POST create" do
    context "when admin" do
      it "redirects to admin" do
        login_admin

        post :create, params: { user: valid_attributes }

        expect(response).to redirect_to admin_path
      end
    end

    context "when user" do
      it "redirects to dashboard" do
        login_user

        post :create, params: { user: valid_attributes }

        expect(response).to redirect_to dashboard_path
      end
    end

    context "when guest" do
      it "redirects to subscribe" do
        post :create, params: { user: valid_attributes }

        expect(response).to redirect_to subscribe_path
      end

      it "increments User.count" do
        expect do
          post :create, params: { user: valid_attributes }
        end.to change { User.count }.by 1
      end
    end
  end

  describe "GET edit" do
    context "when admin" do
      context "and their id is passed" do
        it "renders the template" do
          admin = login_admin

          get :edit, params: { id: admin }

          expect(response).to render_template(:edit)
        end

        it "assigns @user" do
          admin = login_admin

          get :edit, params: { id: admin }

          expect(assigns(:user)).to eq(admin)
        end
      end

      context "and another user id is passed" do
        it "renders the template" do
          admin = create(:user, admin: true)
          another_user = create(:user)
          controller.login(admin)

          get :edit, params: { id: another_user }

          expect(response).to render_template(:edit)
        end

        it "assigns @user" do
          admin = create(:user, admin: true)
          another_user = create(:user)
          controller.login(admin)

          get :edit, params: { id: another_user }

          expect(assigns(:user)).to eq(another_user)
        end
      end
    end

    context "when user" do
      context "and their id is passed" do
        it "renders the template" do
          user = login_user

          get :edit, params: { id: user }

          expect(response).to render_template(:edit)
        end

        it "assigns @user" do
          user = create(:user)
          controller.login(user)

          get :edit, params: { id: user }

          expect(assigns(:user)).to eq(user)
        end
      end

      context "and another user id is passed" do
        it "raises a routing error" do
          login_user
          another_user = create(:user)

          expect do
            get :edit, params: { id: another_user }
          end.to raise_error(ActionController::RoutingError)
        end
      end
    end

    context "when guest" do
      it "redirects to login" do
        get :edit, params: { id: 200 }

        expect(response).to redirect_to login_path
      end
    end
  end

  describe "PUT update"  do
    context "when admin" do
      context "and their id is passed" do
        it "updates the record" do
          admin = login_admin
          valid_attributes[:email] = "newEmail@gexample.com"

          put :update, params: { id: admin, user: valid_attributes }

          expect(admin.reload.email).to eq("newEmail@gexample.com")
        end

        it "renders the show template" do
          admin = login_admin

          put :update, params: { id: admin, user: valid_attributes }

          expect(response).to redirect_to admin
        end
      end

      context "and another user id is passed" do
        it "updates the record" do
          login_admin
          another_user = create(:user)
          valid_attributes[:email] = "newEmail@gexample.com"

          put :update, params: { id: another_user, user: valid_attributes }

          expect(another_user.reload.email).to eq("newEmail@gexample.com")
        end

        it "renders the show template" do
          login_admin
          another_user = create(:user)

          put :update, params: { id: another_user, user: valid_attributes }

          expect(response).to redirect_to another_user
        end
      end
    end

    context "when user" do
      context "and their id is passed" do
        it "updates the record" do
          user = login_user
          valid_attributes[:email] = "newEmail@gexample.com"

          put :update, params: { id: user, user: valid_attributes }

          expect(user.reload.email).to eq("newEmail@gexample.com")
        end

        it "renders the show template" do
          user = login_user

          put :update, params: { id: user, user: valid_attributes }

          expect(response).to redirect_to user
        end
      end

      context "and another user id is passed" do
        it "raises a routing error" do
          login_user
          another_user = create(:user)

          expect do
            put :update, params: { id: another_user, user: valid_attributes }
          end.to raise_error(ActionController::RoutingError)
        end
      end
    end

    context "when guest" do
      it "redirects to login page" do
        put :update, params: { id: 200 }

        expect(response).to redirect_to login_path
      end
    end
  end

  describe "DELETE destroy" do
    context "when admin" do
      context "and their id is passed" do
        it "redirects to login" do
          admin = login_admin

          delete :destroy, params: { id: admin }

          expect(response).to redirect_to(login_path)
        end

        it "clears the user session" do
          admin = login_admin

          delete :destroy, params: { id: admin }

          expect(controller.user?).to eq(false)
        end

        it "decrements User.count" do
          admin = login_admin

          expect do
            delete :destroy, params: { id: admin }
          end.to change { User.count }.by(-1)
        end
      end

      context "and another user id is passed" do
        it "redirects to login" do
          login_admin
          another_user = create(:user)

          delete :destroy, params: { id: another_user }

          expect(response).to redirect_to(login_path)
        end

        it "clears the user session" do
          login_admin
          another_user = create(:user)

          delete :destroy, params: { id: another_user }

          expect(controller.user?).to eq(false)
        end

        it "decrements User.count" do
          login_admin
          another_user = create(:user)

          expect do
            delete :destroy, params: { id: another_user }
          end.to change { User.count }.by(-1)
        end
      end
    end

    context "when user" do
      context "and their id is passed" do
        it "redirects to login" do
          user = login_user

          delete :destroy, params: { id: user }

          expect(response).to redirect_to login_path
        end

        it "clears the user session" do
          user = create :user
          controller.login user

          delete :destroy, params: { id: user }

          expect(controller.user?).to eq false
        end

        it "decrements User.count" do
          user = login_user

          expect do
            delete :destroy, params: { id: user.id }
          end.to change { User.count }.by -1
        end
      end

      context "and another user id is passed" do
        it "raises routing error" do
          login_user
          another_user = create(:user)

          expect do
            delete :destroy, params: { id: another_user }
          end.to raise_error(ActionController::RoutingError)
        end
      end
    end

    context "when guest" do
      it "redirects to login" do
        delete :destroy, params: { id: 200 }

        expect(response).to redirect_to login_path
      end
    end
  end
end
