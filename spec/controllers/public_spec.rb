
require 'rails_helper'

RSpec.describe PublicController, type: :controller do
  describe "test_500" do
    it "throws an exception" do
      expect do
        get :test_500
      end.to raise_error(ZeroDivisionError)
    end
  end
end
