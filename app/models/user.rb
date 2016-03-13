class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :topics
  has_many :bookmarks
  has_many :likes, dependent: :destroy

  def liked(bookmark)
    if bookmark
      likes.where(bookmark_id: bookmark.id).first
    end
  end

  def liked_bookmarks
    likes.includes( bookmark: :topic ).map(&:bookmark)
  end
end
