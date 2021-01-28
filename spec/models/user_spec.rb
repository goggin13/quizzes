require 'rails_helper'

RSpec.describe User, type: :model do
  describe "admin?" do
    it "returns true if the user is an admin" do
      user = FactoryBot.create(:user, :admin)
      expect(user.admin?).to be(true)
    end

    it "returns false if the user is not an admin" do
      user = FactoryBot.create(:user)
      expect(user.admin?).to be(false)
    end
  end
end
