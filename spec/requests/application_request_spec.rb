require 'rails_helper'

RSpec.describe "authentication", type: :request do
  describe "GET /exams" do
    context "unauthenticated user" do
      it "redirects to the public welcome page" do
        get exams_url
        expect(response).to redirect_to(public_index_url)
      end
    end

    context "authenticated non-admin" do
      it "redirects to the public welcome page" do
        sign_in(FactoryBot.create(:user))
        get exams_url
        expect(response).to redirect_to(public_index_url)
      end
    end

    context "authenticated admin" do
      it "succeeds" do
        sign_in(FactoryBot.create(:user, :admin))
        get exams_url
        expect(response).to be_successful
      end
    end
  end
end
