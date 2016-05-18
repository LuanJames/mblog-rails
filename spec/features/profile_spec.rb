require 'rails_helper'
# RSpec.configure do |config|
#   config.include Features::SessionHelpers
# end

feature 'ProfilePage' do
  let(:user)  { FactoryGirl.create :user}
  let(:user2) { FactoryGirl.create :user}
  let(:user3) { FactoryGirl.create :user}

  describe 'without login' do
    # scenario 'cannot follow users', js: true do
    #   visit profile_path(user.username)

    #   click_button 'Follow'

    #   expect(page).to have_current_path(new_user_session_path)
    # end

    # scenario "can see user's post" do
    #   list = FactoryGirl.create_list :post, 8, user: user
    #   visit profile_path(user.username)
    #   items = find('.posts').all('.post').map{|i| i.id}
    #   expect(items).to match_array(list.map {|p| 'item-'+p.id.to_s })
    # end
  end

  describe 'with login' do
    before do
      login_user user2
    end
    # scenario 'cannot follow heself' do
    #   visit profile_path(user2.username)

    #   expect(page).to have_no_button('Follow')
    # end

    # scenario 'can follow user' do
    #   visit profile_path(user.username)
    #   click_button 'Follow'
    #   expect(page).to have_button('Unfollow')
    # end

    # scenario 'can follow two or more users' do
    #   visit profile_path(user.username)
    #   click_button 'Follow'
    #   visit profile_path(user3.username)
    #   click_button 'Follow'

    #   visit profile_path(user2.username)
    #   expect(page).to have_content('2 following')

    #   visit profile_path(user.username)
    #   expect(page).to have_content('1 followers')
    # end

    scenario 'has num count notification' do
      user2.following << user
      logout_user

      login_user user
      visit root_path

      expect(find('#followers')).to have_content('1')
    end

    # scenario 'read notification' do
    #   visit profile_path(user.username)
    #   click_button 'Follow'
    #   visit profile_path(user3.username)
    #   click_button 'Follow'
    #   logout_user

    #   login_user user3
    #   visit profile_path(user.username)
    #   click_button 'Follow'
    #   logout_user

    #   login_user user
    #   click_button '#read-notifications'

    #   expect(Relationship.where(to_id: user.id).count).to eq 0
    # end


    # scenario 'can write post' do
    #   visit profile_path(user2.username)
    #   text = Faker::Lorem.paragraph
    #   fill_in '#post-content', with: text
    #   find('#create-post').click
    #   expect(page).to have_content(text)
    #   expect(Post.where(user: user2, content: text).size).to eq 1
    # end
  end
end