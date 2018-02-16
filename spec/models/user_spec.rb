require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: "theotheo@meowmeowmeowm.com", password: 'meowmeow') }

  it { is_expected.to have_many(:wikis) }

  describe "attributes" do
    it "should have email and password attributes" do
      expect(user).to have_attributes(email: user.email, password: user.password)
    end

    it "should have a role attribute" do
      expect(user).to have_attributes(role: user.role)
    end
  end

  describe "roles" do
    it "should be standard by default" do
      expect(user.role).to eq("standard")
    end

    it "should return true for #standard" do
      user.standard!
      expect(user.role).to eq("standard")
      expect(user.standard?).to be_truthy
    end

    it "should return true for #premium" do
      user.premium!
      expect(user.role).to eq("premium")
      expect(user.premium?).to be_truthy
    end

    it "should return true for #admin" do
      user.admin!
      expect(user.role).to eq("admin")
      expect(user.admin?).to be_truthy
    end
  end


end
