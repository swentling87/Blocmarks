class LikesController < ApplicationController

  def index
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    if like.save
      flash[:notice] = "Bookmark was liked."
    else
      flash.now[:alert] = "There was an error liking that bookmark. Please try again."
    end
    redirect_to @bookmark.topic
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.find(params[:id])

    if like.destroy
      flash[:notice] = "Bookmark was unliked."
    else
      flash.now[:alert] = "There was an error un-liking that bookmark. Please try again."
    end
    redirect_to @bookmark.topic
  end

end
