class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.create(bookmark_params)

    if @bookmark.save
      redirect_to @bookmark.topic
    else
      redirect_to @bookmark.topic
    end
  end

  def edit
    @bookmark = Bookmark.find(params[:id])
  end

  def update
    @bookmark = Bookmark.find(params[:id])
    @bookmark.assign_attributes(bookmark_params)

    if @bookmark.save
      redirect_to @bookmark.topic
    else
      redirect_to @bookmark.topic
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    if @bookmark.destroy
      redirect_to @bookmark.topic
    else
      redirect_to @bookmark.topic
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end
end
