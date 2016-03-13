class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!

  def create
    @user = User.find_by_email(params[:sender])
    @topic = Topic.find_or_create_by(title: params[:subject])
    @bookmark = @topic.bookmarks.find_or_create_by(url: params["body-plain"])

    if @user.nil?
      @user = User.create!(email: params[:sender], password: "helloworld", password_confirmation: "helloworld")
    end

    @bookmark.save
    head 200
  end
end
