require "rails_helper"

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }

  it "has a valid factory" do
    expect(create(:user)).to be_truthy
  end

  it "hashes password before save" do
    user.password = "something"
    user.save
    user.reload

    expect(BCrypt::Password.valid_hash?(user.password)).to be_truthy
  end

  describe "#authenticate" do
    context "when password correct" do
      it "returns true" do
        expect(user.authenticate("password")).to eq true
      end
    end

    context "when password in-correct" do
      it "returns false" do
        expect(user.authenticate("incorrect")).to eq false
      end
    end
  end
end
