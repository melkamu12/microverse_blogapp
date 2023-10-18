require 'rails_helper'
RSpec.describe 'User Show page Testing', type: :feature do
  let(:user) do
    User.create(
      name: 'Melkamu',
      photo: 'https://avatars.githubusercontent.com/u/8255233?v=4',
      bio: 'Software Developer.',
      posts_counter: 7
    )
  end

  before do
    @posts = [
      Post.create(
        author: user,
        title: 'Post 1',
        text: 'Text post 1',
        comments_counter: 2,
        likes_counter: 3
      ),
      Post.create(
        author: user,
        title: 'Post 2',
        text: 'Text post 2',
        comments_counter: 1,
        likes_counter: 5
      ),
      Post.create(
        author: user,
        title: 'Post 3',
        text: 'Text post 3',
        comments_counter: 4,
        likes_counter: 7
      )
    ]
    visit user_path(user)
  end
  it ' can see the users profile picture.' do
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  it 'Can see the users username.' do
    expect(page).to have_content(user.name)
  end

  it 'Can see the number of posts the user has written.' do
    expect(page).to have_content("Number of posts : #{user.posts_counter}")
  end

  it 'Can see the users bio.' do
    expect(page).to have_content(user.bio)
  end

  it 'can see the users first 3 posts' do
    user.recent_posts.each do |post|
      expect(page).to have_content(post.text)
    end
  end

  it 'can see a button that lets me view all of a user\'s posts.' do
    expect(page).to have_link('See All Post', href: user_posts_path(user), class: 'see-all-btn')
  end

  it 'When I click a users post, it redirects me to that posts show page' do
    post = user.recent_posts.first
    click_link("user_post_#{post.id}")
    expect(page).to have_current_path(user_post_path(user, post))
  end

  it 'When I click to see all posts, it redirects me to the users posts index page.' do
    click_link 'See All Post'
    expect(current_path).to eq(user_posts_path(user))
  end
end
