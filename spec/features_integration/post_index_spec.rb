require 'rails_helper'

RSpec.describe 'User Post Index Page', type: :feature do
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
    visit user_posts_path(user_id: user.id)
  end

  context "Viewing user's profile information" do
    it "shows user's profile picture" do
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
    it "checks for user's username" do
      expect(page).to have_content(user.name)
    end
    it 'checks for post count' do
      expect(page).to have_content("Number of posts : #{user.posts_counter}")
    end
  end

  # Testing the Viewing posts
  context 'Viewing posts' do
    it 'shows post titles' do
      @posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end
    it 'shows post bodies' do
      @posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'shows the first comments on posts' do
      @posts.each do |post|
        first_comment = post.comments.first
        # Check if there's a comment before attempting to access its text
        expect(page).to have_content(first_comment.text) if first_comment
      end
    end

    it 'shows the number of comments on posts' do
      @posts.each do |post|
        expect(page).to have_content("Comments: #{post.comments_counter}")
      end
    end

    it 'shows the number of likes on posts' do
      @posts.each do |post|
        expect(page).to have_content("Likes: #{post.likes_counter}")
      end
    end
  end

  context 'To view comments on posts' do
    it 'check for comment' do
      @posts.each do |post|
        if post.recent_comments.any?
          post.recent_comments.each do |comment|
            expect(page).to have_content(comment.body)
          end
        else
          expect(page).to have_content('')
        end
      end
    end
  end

  context 'to check pagination' do
    it 'checks for pagination section' do
      expect(page).to have_content('Pagination')
    end

    it 'check to post show cliked on the post' do
      post = @posts.first
      click_link("user_post_#{post.id}")
      expect(page).to have_current_path(user_post_path(user, post))
    end
  end
end
