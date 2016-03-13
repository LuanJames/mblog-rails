require 'rails_helper'
# RSpec.configure do |config|
#   config.include Features::SessionHelpers
# end
feature 'ProfilePage' do
  let(:user)  { FactoryGirl.create :user}
  let(:user2) { FactoryGirl.create :user}
  let(:user3) { FactoryGirl.create :user}

  describe 'without login' do
    scenario 'cannot follow users' do
      visit profile_path(user.username)

      click_button 'Follow'

      expect(page).to have_current_path(new_user_session_path)
    end

    scenario "can see user's post" do
      list = FactoryGirl.create_list :post, 8, user: user
      visit profile_path(user.username)
      items = page.all('.items').map{|i| i.id}
      expect(items).to match_array(list.map {|p| 'item-'+p.id.to_s })
    end
  end

  describe 'with login' do
    before do
      login_user user2
    end
    scenario 'cannot follow heself' do
      visit profile_path(user2.username)

      expect(page).to have_no_button('Follow')
    end

    scenario 'can follow user' do
      visit profile_path(user.username)
      click_button 'Follow'
      expect(page).to have_button('Unfollow')
    end

    scenario 'can follow two or more users' do
      visit profile_path(user.username)
      click_button 'Follow'
      visit profile_path(user3.username)
      click_button 'Follow'

      visit profile_path(user2.username)
      expect(page).to have_content('2 following')

      visit profile_path(user.username)
      expect(page).to have_content('1 followers')
    end

    scenario 'has num count notification' do
      visit profile_path(user.username)
      click_button 'Follow'
      visit profile_path(user3.username)
      click_button 'Follow'
      logout_user

      login_user user3
      visit profile_path(user.username)
      click_button 'Follow'
      logout_user

      login_user user

      expect(find('.notification')).to have_content('2')
    end

    scenario 'can write post' do
      visit profile_path(user2.username)
      text = Faker::Lorem.paragraph
      fill_in 'Text', with: text
      click_button 'Post'
      expect(page).to have_content(text)
      expect(Post.where(user: user2, content: text).size).to eq 1
    end
  end
end