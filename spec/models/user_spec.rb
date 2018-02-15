require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: "theotheo@meowmeowmeowm.com", password: 'meowmeow') }

  it { is_expected.to have_many(:wikis) }

  describe "attributes" do
    it "should have email and password attributes" do
      expect(user).to have_attributes(email: user.email, password: user.password)
    end
  end


end
