require 'rails_helper'
RSpec.describe 'User Index page Testing', type: :feature do
  before(:each) do
    @users = [
      @user1 = User.create(
        name: 'Melkamu Almawu',
        photo: 'https://avatars.githubusercontent.com/u/8255233?v=4',
        bio: 'Software developer',
        posts_counter: 6
      ),
      @user1 = User.create(
        name: 'Hafiz Massam',
        photo: 'https://avatars.githubusercontent.com/u/109702354?v=4',
        bio: 'Software developer',
        posts_counter: 0
      )
    ]
    visit users_url
  end

  it ' can see the username of all other users' do
    @users.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'can see the profile picture for each user' do
    @users.each do |user|
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
  end
  it 'can see the number of posts each user has written' do
    @users.each do |user|
      expect(page).to have_content("Number of posts : #{user.posts_counter}")
    end
  end
  it 'When I click on a user, I am redirected to that users show page.' do
    click_link(@users[0].name)
    expect(page).to have_current_path(user_path(@users[0]))
  end
end
