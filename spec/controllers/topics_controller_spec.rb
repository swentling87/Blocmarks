require 'rails_helper'

RSpec.describe TopicsController, type: :controller do


context "user" do
  before do
    @user = FactoryGirl.create(:user)
    sign_in :user, @user
    @topic = FactoryGirl.create(:topic)
  end
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, {id: @topic.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, {id: @topic.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST create" do
      it "increases the topic count by 1" do
        expect{ post :create, topic: {title: "Hello World"}}.to change(Topic,:count).by(1)
      end
    end

    describe "PUT update" do
      it "returns the correct title" do
        new_title = "Hello World"
        put :update, id: @topic.id, topic: {title: new_title }
        updated_topic = assigns(:topic)
        expect(updated_topic.title).to eq(new_title)
      end
    end

    describe "DELETE destroy" do
      it "deletes the topic" do
        delete :destroy, {id: @topic.id}
        expect(Topic.count).to eq(0)
      end
    end
  end

  context "non-user" do
    before do
      @topic = FactoryGirl.create(:topic)
    end
      describe "GET #index" do
        it "redirects to sign in" do
          get :index
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      describe "GET #show" do
        it "redirects to sign in" do
          get :show, {id: @topic.id}
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      describe "GET #new" do
        it "redirects to sign in" do
          get :new
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      describe "GET #edit" do
        it "redirects to sign in" do
          get :edit, {id: @topic.id}
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

end
