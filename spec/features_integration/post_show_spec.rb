require 'rails_helper'

RSpec.describe 'User Post Show Page', type: :feature do
  let(:user) do
    User.create(
      name: 'Melkamu',
      photo: 'https://avatars.githubusercontent.com/u/8255233?v=4',
      bio: 'Software Developer.',
      posts_counter: 7
    )
  end

  before do
    @post = Post.create(
      author: user,
      title: 'Post 1',
      text: 'Text post 1',
      comments_counter: 2,
      likes_counter: 3
    )
    visit user_post_path(user_id: user.id, id: @post.id)
  end

  it "can see the post's title" do
    expect(page).to have_content(@post.title)
  end

  it 'can see who wrote the post' do
    expect(page).to have_content("by #{user.name}")
  end

  it 'can see how many comments it has' do
    expect(page).to have_content('Comments: 2')
  end

  it 'can see how many likes it has' do
    expect(page).to have_content('Likes: 3')
  end

  it 'can see the post body' do
    expect(page).to have_content(@post.text)
  end

  it 'can see the username of each commentator' do
    comment = Comment.create(post: @post, user:, text: 'Comment text')
    visit user_post_path(user_id: user.id, id: @post.id)
    expect(page).to have_content(comment.user.name)
  end

  it 'can see the comment each commentator left' do
    comment = Comment.create(post: @post, user:, text: 'Comment text')
    visit user_post_path(user_id: user.id, id: @post.id)
    expect(page).to have_content(comment.text)
  end
end
