class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks

  default_scope { order('title ASC')}

end
