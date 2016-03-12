require 'rails_helper'

RSpec.describe LikesController, type: :controller do

  context "user performing authorized actions" do
    before do
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
      @topic = FactoryGirl.create(:topic)
      @bookmark = FactoryGirl.create(:bookmark, user_id: @user.id, topic_id: @topic.id)
    end

    describe "POST create" do
      it "assigns a bookmark as 'liked' for a user" do
        expect(@user.likes.count).to eq(0)
        post :create, { bookmark_id: @bookmark.id }
        expect(@user.likes.count).to eq(1)
      end
    end

    describe "DELETE destroy" do
      it "deletes the like" do
        like = @user.likes.where(bookmark: @bookmark).create
        delete :destroy, { bookmark_id: @bookmark.id, id: like.id }
        expect(@user.likes.count).to eq(0)
      end
    end
  end
end
