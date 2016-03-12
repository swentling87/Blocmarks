require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do

  context "user performing authorized actions" do
    before do
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
      @topic = FactoryGirl.create(:topic)
      @bookmark = FactoryGirl.create(:bookmark, user_id: @user.id)
    end

      describe "GET #show" do
        it "returns http success" do
          get :show, {topic_id: @topic.id, id: @bookmark.id, user_id: @user.id}
          expect(response).to have_http_status(:success)
        end
      end

      describe "GET #new" do
        it "returns http success" do
          get :new, {topic_id: @topic.id, id: @bookmark.id, user_id: @user.id}
          expect(response).to have_http_status(:success)
        end
      end

      describe "GET #edit" do
        it "returns http success" do
          get :edit, {user_id: @user.id, topic_id: @topic.id, id: @bookmark.id}
          expect(response).to have_http_status(:success)
        end
      end

      describe "POST create" do
        it "increases the bookmark count by 1" do
          expect{ post :create, topic_id: @topic.id, user_id: @user.id, bookmark: {url: "Hello World"}}.to change(Bookmark,:count).by(1)
        end
      end

      describe "PUT update" do
        it "returns the correct title" do
          new_bookmark = "Hello World"
          put :update, topic_id: @topic.id, id: @bookmark.id, user_id: @user.id, bookmark: {url: new_bookmark }
          updated_bookmark = assigns(:bookmark)
          expect(updated_bookmark.url).to eq(new_bookmark)
        end
      end

      describe "DELETE destroy" do
        it "deletes the bookmark" do
          expect{ delete :destroy, topic_id: @topic.id, user_id: @user.id, id: @bookmark.id}.to change(Bookmark,:count).by(-1)
        end
      end
    end

    context "user performing non-authorized actions" do
      before do
        @user = FactoryGirl.create(:user)
        @luser = FactoryGirl.create(:user, email: "luser@blocmarks.com")
        sign_in :user, @luser
        @topic = FactoryGirl.create(:topic)
        @bookmark = FactoryGirl.create(:bookmark, user_id: @user.id)
      end

        describe "GET #show" do
          it "returns http success" do
            get :show, {topic_id: @topic.id, id: @bookmark.id, user_id: @luser.id}
            expect(response).to have_http_status(:success)
          end
        end

        describe "GET #new" do
          it "returns http success" do
            get :new, {topic_id: @topic.id, id: @bookmark.id, user_id: @luser.id}
            expect(response).to have_http_status(:success)
          end
        end

        describe "GET #edit" do
          it "returns http success" do
            get :edit, {user_id: @luser.id, topic_id: @topic.id, id: @bookmark.id}
            expect(response).to have_http_status(:success)
          end
        end

        describe "POST create" do
          it "increases the bookmark count by 1" do
            expect{ post :create, topic_id: @topic.id, user_id: @luser.id, bookmark: {url: "Hello World"}}.to change(Bookmark,:count).by(1)
          end
        end

        describe "PUT update" do
          it "redirects to the root path by failing authorization" do
            new_bookmark = "Hello World"
            put :update, topic_id: @topic.id, id: @bookmark.id, user_id: @luser.id, bookmark: {url: new_bookmark }
            updated_bookmark = assigns(:bookmark)
            expect(response).to redirect_to(root_path)
          end
        end

        describe "DELETE destroy" do
          it "redirects to the root path by failing authorization" do
            delete :destroy, topic_id: @topic.id, id: @bookmark.id
            expect(response).to redirect_to(root_path)
          end
        end
    end

    context "non-user" do
      before do
        @topic = FactoryGirl.create(:topic)
        @bookmark = FactoryGirl.create(:bookmark)
      end

        describe "GET #show" do
          it "redirects to sign in" do
            get :show, {topic_id: @topic.id, id: @bookmark.id}
            expect(response).to redirect_to(new_user_session_path)
          end
        end

        describe "GET #new" do
          it "redirects to sign in" do
            get :new, {topic_id: @topic.id, id: @bookmark.id}
            expect(response).to redirect_to(new_user_session_path)
          end
        end

        describe "GET #edit" do
          it "redirects to sign in" do
            get :edit, {topic_id: @topic.id, id: @bookmark.id}
            expect(response).to redirect_to(new_user_session_path)
          end
        end
      end

end
