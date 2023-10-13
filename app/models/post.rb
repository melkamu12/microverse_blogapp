class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { greater_than_or_equal_to: 0 }

  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'
  belongs_to :author, class_name: 'User'

  after_save :update_postscounter_user
  after_initialize :set_counters_tozero

  def set_counters_tozero
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end

  def update_postscounter_user
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments(num = 5)
    comments.order(created_at: :desc).limit(num)
  end
end
