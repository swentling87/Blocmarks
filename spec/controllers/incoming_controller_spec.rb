require 'rails_helper'

RSpec.describe IncomingController, type: :controller do

    context "Blocmarks receives a new email" do
      before do
        @message = Mail.new(sender: 'user2@blocmarks.com',
                    subject: 'Seahawks',
                    body: 'www.seahawks.com')
      end

      describe "receives an email from a non-user" do
        it "creates a new user" do
          expect(User.count).to eq(0)
          post :create, { sender: @message.sender, subject: @message.subject, body: @message.body }
          expect(User.count).to eq(1)
        end
      end

      describe "receives an email for a new topic" do
        it "creates a new topic" do
          expect(Topic.count).to eq(0)
          post :create, { sender: @message.sender, subject: @message.subject, body: @message.body }
          expect(Topic.count).to eq(1)
        end
      end

      describe "receives an email and creates a new blocmark" do
        it "creates a new bookmark" do
          expect(Bookmark.count).to eq(0)
          post :create, { sender: @message.sender, subject: @message.subject, body: @message.body, topic_id: 1 }
          expect(Bookmark.count).to eq(1)
        end
      end
    end
end
