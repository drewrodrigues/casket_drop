require "rails_helper"

RSpec.describe Stripeable do
  let(:card_token) { StripeMock.generate_card_token }

  describe "#subscribe" do
    context "when user isn't subscribed" do
      it "subscribes the user to the stripe plan" do
        user = create(:user)

        user.subscribe(card_token)

        stripe = Stripe::Customer.retrieve(user.stripe_id)
        expect(stripe.subscriptions.total_count).to eq(1)
      end

      it "sets the user's stripe_id" do
        user = create(:user)
        
        user.subscribe(card_token)

        expect(user.reload.stripe_id).to_not be_nil
      end

      it "sets the user's current_period_end out a month" do
        Timecop.freeze(Date.today)
        user = create(:user)
        
        user.subscribe(card_token)

        expect(user.reload.current_period_end).to eq(Date.today + 31)
      end
      
      it "sets subscribed to true" do
        user = create(:user)

        user.subscribe(card_token)

        expect(user.reload.subscribed?).to eq(true)
      end
    end

    context "when user already subscribed" do
      it "doesn't change the user's stripe_id" do
        user = create(:user)
        user.subscribe(card_token)

        expect {
          user.subscribe(card_token)
        }.to_not change(user, :stripe_id)
      end

      it "doesn't double subscribe the user" do
        user = create(:user)
        user.subscribe(card_token)

        user.subscribe(card_token)

        stripe = Stripe::Customer.retrieve(user.stripe_id)
        expect(stripe.subscriptions.total_count).to eq(1)
      end

      it "doesn't change the user's current_period_end" do
        Timecop.freeze(Date.today)
        user = create(:user)
        user.subscribe(card_token)
        Timecop.freeze(Date.today + 2)

        expect {
          user.subscribe(card_token)
        }.to_not change(user, :current_period_end)
      end
    end
  end
end
