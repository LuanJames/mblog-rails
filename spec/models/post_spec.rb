require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validations' do
    subject { FactoryGirl.build :post }

    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to belong_to(:user) }
  end

  context 'hooks' do

    it 'when create, notify followers' do
      user = FactoryGirl.create :user
      list = FactoryGirl.create_list :user, 5

      list.each {|u| u.following << user}

      post = FactoryGirl.create :post, user: user

      list.each do |u|
        expect(u.unread_notifications.map {|n| n.post_id}).to include post.id
      end

    end
  end
end
