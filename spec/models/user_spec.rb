require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_length_of(:password).is_at_least(8) }

  it "validates uniqueness of email" do
    expect(user).to validate_uniqueness_of(:email).ignoring_case_sensitivity
  end

  it "has a valid factory" do
    expect(build(:user)).to be_truthy
  end

  it "has many orders" do
    expect(build(:user).respond_to?(:orders)).to be true
  end

  describe "admin" do
    it "sets admin to false by default" do
      user = User.new

      expect(user.admin).to eq(false)
    end

    it "accepts true and false" do
      [true, false].each do |val|
        user.admin = val

        expect(user.save).to eq(true)
      end
    end
  end

  describe "password" do
    it "hashes password before save" do
      user.password = "something"
      user.save
      user.reload

      expect(BCrypt::Password.valid_hash?(user.password)).to be_truthy
    end

    it "doesn't rehash password if already hashed" do
      password_hash_before = user.password
      user.save
      user.reload

      expect(user.password).to eq(password_hash_before)
    end
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
