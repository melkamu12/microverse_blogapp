require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:all) do
    @user = User.create(
      name: 'Robel',
      bio: 'Bio of Robel',
      posts_counter: 0
    )
    @post = Post.create(
      title: 'Blog App',
      text: 'Ruby on Rails',
      author_id: @user.id,
      comments_counter: 0,
      likes_counter: 0
    )
  end

  it 'increments post.likes_counter when new likes are created' do
    expect do
      Like.create(user_id: @user.id, post_id: @post.id)
      Like.create(user_id: @user.id, post_id: @post.id)
      @post.reload
    end.to change { @post.likes_counter }.from(0).to(2)
  end
end
