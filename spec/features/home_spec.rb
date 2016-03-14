require 'rails_helper'
# RSpec.configure do |config|
#   config.include Features::SessionHelpers
# end

feature 'HomePage' do
  let(:user)  { FactoryGirl.create :user}
  let(:user2) { FactoryGirl.create :user}
  let(:user3) { FactoryGirl.create :user}

  context 'without login' do
    it 'do not have create first post button' do
      visit root_path

      expect(page).not_to have_content(I18n.t('view.create_first_post'))
    end
  end
  context 'with login' do
    context 'with post' do
      it 'have create first post button' do
        user = FactoryGirl.create :user
        
        login_user user
        FactoryGirl.create :post, user: user
        
        visit root_path

        expect(page).not_to have_content(I18n.t('view.create_first_post'))
      end
    end

    context 'without post' do
      it 'do not have create first post button' do
        login_user

        visit root_path

        expect(page).to have_content(I18n.t('view.create_first_post'))
      end
    end
  end
end