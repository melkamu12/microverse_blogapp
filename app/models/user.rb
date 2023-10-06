class User < ApplicationRecord
  has_many :posts, foreign_key: 'AuthorId'
  has_many :comments, foreign_key: 'comment_id'
  has_many :likes, foreign_key: 'like_id'

  def recent_post
    posts.order(created_at: :desc).limit(3)
  end
end
