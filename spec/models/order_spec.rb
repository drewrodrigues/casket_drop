require "rails_helper"

RSpec.describe Order, type: :model do
  it "has a valid factory" do
    expect(build(:order)).to be_valid
  end

  it "belongs to a user" do
    expect(build(:order).respond_to?(:user)).to be true
  end

  describe "status" do
    it "allows new, attention and complete" do
      order = build(:order)

      %i(new attention complete).each do |status|
        order.status = status
        expect(order).to be_valid
      end
    end

    it "is required" do
      order = build(:order)

      order.status = nil

      expect(order).to be_invalid
    end

    it "is set to new by default" do
      order = Order.new

      expect(order.status).to eq("new")
    end
  end
end
