require 'rails_helper'
require 'devise'

RSpec.describe User, type: :model do

  describe "create user" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    it "should create a new user" do
      expect(User.all).to_not be_nil
    end
    it "should show one user" do
      expect(User.count).to eq(1)
    end
  end

end
