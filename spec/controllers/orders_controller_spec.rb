require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  it "redirects guest to login on all actions" do
    get :index
    expect(response).to redirect_to(login_path)

    order = create(:order)
    get :show, params: { id: order }
    expect(response).to redirect_to(login_path)

    get :new
    expect(response).to redirect_to(login_path)

    post :create
    expect(response).to redirect_to(login_path)

    get :edit, params: { id: order }
    expect(response).to redirect_to(login_path)

    put :update, params: { id: order}
    expect(response).to redirect_to(login_path)

    delete :destroy, params: { id: order }
    expect(response).to redirect_to(login_path)
  end

  it "raises routing error on user on all actions" do
    login_user 

    expect do
      get :index
    end.to raise_error ActionController::RoutingError

    order = create(:order)
    expect do
      get :show, params: { id: order }
    end.to raise_error ActionController::RoutingError

    expect do
      get :new
    end.to raise_error ActionController::RoutingError

    expect do
      post :create
    end.to raise_error ActionController::RoutingError

    expect do
      get :edit, params: { id: order }
    end.to raise_error ActionController::RoutingError

    expect do
      put :update, params: { id: order}
    end.to raise_error ActionController::RoutingError
    
    expect do
      delete :destroy, params: { id: order }
    end.to raise_error ActionController::RoutingError
  end

  context "when admin" do
    before do
      login_admin
    end

    describe "GET index" do
      it "assigns @orders" do
        get :index

        expect(assigns(:orders)).to eq(Order.all)
      end
      
      it "renders the index tempate" do
        get :index

        expect(response).to render_template :index
      end
    end

    describe "GET show" do
      it "assigns @order" do
        order = create(:order)
        
        get :show, params: { id: order }

        expect(assigns(:order)).to eq(order)
      end

      it "renders the show template" do
        order = create(:order)

        get :show, params: { id: order }

        expect(response).to render_template :show
      end
    end

    describe "GET new" do
      it "assigns @order" do
        order = Order.new
        allow(Order).to receive(:new) { order }

        get :new

        expect(assigns(:order)).to eq(order)
      end

      it "renders the new template" do
        get :new
        
        expect(response).to render_template :new
      end
    end

    describe "POST create" do
      context "valid order" do
        it "redirects to show" do
          user = create(:user)
          order = build(:order, user: user)

          post :create, params: { order: order.attributes }

          expect(response).to redirect_to(Order.last)
        end

        it "increments order count" do
          # TODO: better way to do this?
          user = create(:user)
          order = build(:order, user: user)

          expect do
            post :create, params: { order: order.attributes }
          end.to change(Order, :count).by(1)
        end
      end

      context "invalid order" do
        it "renders new" do
          order = Order.new
          order.status = nil

          post :create, params: { order: order.attributes }

          expect(response).to render_template :new
        end
      end
    end

    describe "GET edit" do
      it "assigns @order" do
        order = create(:order)

        get :edit, params: { id: order }

        expect(assigns(:order)).to eq(order) 
      end

      it "renders the edit template" do
        order = create(:order)

        get :edit, params: { id: order }

        expect(response).to render_template :edit
      end
    end

    describe "PUT update" do
      context "valid update" do
        it "redirects to show" do
          order = create(:order)

          order.details = "something new"
          put :update, params: { id: order, order: order.attributes }

          expect(response).to redirect_to(order)
        end
      end

      context "invalid update" do
        it "renders the edit template" do
          order = create(:order)

          order.status = "invalid status"
          put :update, params: { id: order, order: order.attributes }

          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE destroy" do
      it "redirects to index" do
        order = create(:order)

        delete :destroy, params: { id: order }

        expect(response).to redirect_to(orders_path)
      end

      it "decrements the order count" do
        order = create(:order)

        expect do
          delete :destroy, params: { id: order }
        end.to change(Order, :count).by(-1)
      end
    end
  end
end
