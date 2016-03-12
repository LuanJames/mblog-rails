require 'rails_helper'

feature 'Signs in' do

  scenario 'withs valid user' do
    login_user
    expect(page).to have_content('Sign out')
  end

  scenario 'with invalid user' do
    login_user FactoryGirl.build :user

    expect(page).to have_button('Log in')
  end
end