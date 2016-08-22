class TopicsController < ApplicationController

  before_action :authenticate_user!
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      flash[:notice] = "Topic was created."
      redirect_to @topic
    else
      flash.now[:alert] = "There was an error creating the topic. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash.now[:alert] = "There was an error updating the topic. Please try again."
      render :edit
    end
  end

  def destroy
     @topic = Topic.find(params[:id])

     if @topic.destroy && (@topic.bookmarks.count == 0)
       flash[:notice] = "Topic was deleted."
       redirect_to action: :index
     else
       flash.now[:alert] = "There was an error deleting the topic. Please try again."
       render :show
     end
   end

  private

  def topic_params
    params.require(:topic).permit(:title)
  end

end
