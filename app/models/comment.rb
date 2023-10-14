class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_create :increment_postcomments_counter
  after_destroy :decrement_postcomments_counter

  def increment_postcomments_counter
    post.increment!(:comments_count)
  end

  def decrement_postcomments_counter
    post.decrement!(:comments_count)
  end
end
