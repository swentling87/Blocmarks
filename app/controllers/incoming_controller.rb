class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    @user = User.find(params[:sender])
    @topic = Topic.find(params[:subject])
    @bookmark = @topic.bookmarks.create(params["body-plain"])

    if @user.nil?
      @user = User.create!(email: params[:sender], password: Devise.friendly_token.first(8), password_confirmation:  Devise.friendly_token.first(8))
    end

    if @topic.nil?
      @topic = Topic.new(params[:subject])
      @topic.save
    end
    
    @bookmark.save
    head 200
  end
end
