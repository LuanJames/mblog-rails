require 'rails_helper'

feature 'Signs up' do
  scenario 'with valid name username email and password' do
    user = FactoryGirl.build :user
    sign_up_with user.name, user.username, user.email, user.password

    expect(page).to have_content('Sign out')
  end

  scenario 'with invalid username' do
    user = FactoryGirl.build :user
    sign_up_with user.name, '', user.email, user.password

    expect(page).to have_content("Username can't be blank")
  end


  scenario 'with invalid email' do
    user = FactoryGirl.build :user
    sign_up_with user.name, user.username, '123', user.password

    expect(page).to have_content('Email is invalid')
  end

  scenario 'with blank password' do
    user = FactoryGirl.build :user
    sign_up_with user.name, user.username, user.email, ''

    expect(page).to have_content("Password can't be blank")
  end
end