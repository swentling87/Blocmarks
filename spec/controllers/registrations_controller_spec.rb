require 'rails_helper'
require 'devise'

RSpec.describe RegistrationsController, type: :controller do

  describe "login user" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    it "should show a user is logged in" do
      sign_in @user
      expect(subject.current_user).to_not be_nil
    end
  end

end
