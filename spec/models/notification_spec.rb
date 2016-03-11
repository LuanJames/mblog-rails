require 'rails_helper'

RSpec.describe Notification, type: :model do
  context 'validations' do
    subject { FactoryGirl.create :notification }

    it { is_expected.to belong_to(:post) }  
    it { is_expected.to belong_to(:user) }  
    it { is_expected.to validate_presence_of(:post) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_uniqueness_of(:post_id).scoped_to(:user_id) }

  end

  describe '.make_as_read' do

    before do
      @user = FactoryGirl.create :user
      @users = FactoryGirl.create_list :user, 2
      @users.each { |u| u.following << @user }

      @posts = FactoryGirl.create_list :post, 5, user: @user

    end

    it 'read two or more' do
      ids = @posts.map {|p| p.id}
      del = ids.sample(2)
      Notification.make_as_read_by_post_id(del, @users[0])
      expect(@users[0].unread_notifications.map{|n| n.post_id}).to eq(ids - del)
      expect(@users[1].unread_notifications.map{|n| n.post_id}).to eq(ids)
    end
  end
end
