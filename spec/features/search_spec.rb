require 'rails_helper'
# RSpec.configure do |config|
#   config.include Features::SessionHelpers
# end
feature 'Search' do
  scenario 'with void current_user' do
    visit search_path

    expect(page).to have_current_path(new_user_session_path)
  end

  describe 'with current_user' do
    before do
      login_user
    end
    scenario 'with current_user' do
      visit search_path

      expect(page).to have_button('Search')

    end

    scenario 'with valid expression' do
      FactoryGirl.create_list :user, 10, name: 'J1am'+Faker::Name::name
      list = FactoryGirl.create_list :user, 2, name: 'J2am'+Faker::Name::name

      visit search_path

      fill_in 'navbarInput-01', with: 'j2am'
      find('#btn-search').click

      expect(page).to have_content(list[0].name)
      expect(page).to have_content(list[1].name)
    end
  end
end