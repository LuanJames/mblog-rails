require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
  	subject { FactoryGirl.build :user }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:username) } 
    it { is_expected.to validate_presence_of(:password) }  
    it { is_expected.to validate_uniqueness_of(:username) }
  end

  context 'relationships' do
    let(:users) {  FactoryGirl.create_list(:user, 3)  }
    describe '#following' do

      it 'has nothing' do
        expect(users[0].following.size).to eq 0
      end

      it 'a relationship has created' do
        users[0].following << users[1]
        expect(Relationship.where(from: users[0], to: users[1]).count).to eq(1)
      end

      it 'do not has two relationship with same users' do
        users[0].following << users[1]
        
        expect { users[0].following << users[1] } .to raise_error ActiveRecord::RecordInvalid
      end

      it 'remove a relationship' do
        users[0].following << users[2]
        users[0].following << users[1]
        users[0].following.delete users[2]
        expect(users[0].following).to include users[1]
      end

      it 'return a array of users' do
        users[0].following << users[2]
        users[0].following << users[1]
        expect(users[0].following).to include users[2], users[1]
      end
    end

    describe '#followers' do
      it 'return a array of users' do 
        users[0].following << users[2]
        expect(users[2].followers).to include users[0]
      end

      it 'has nothing' do
        expect(users[0].followers.size).to eq 0
      end

      it 'cannot remove a follower'
    end
  end

  context 'notifications' do
    describe '#read_notifications' do

      before do
        @user = FactoryGirl.create :user
        @users = FactoryGirl.create_list :user, 2
        @users.each { |u| u.following << @user }

        @posts = FactoryGirl.create_list :post, 5, user: @user

      end

      it 'read two or more' do
        ids = @posts.map {|p| p.id}
        del = ids.sample(2)
        @users[0].read_notifications = Notification.where('post_id in (?) and user_id = ?', del, @users[0]).select :id
        expect(@users[0].unread_notifications.map{|n| n.post_id}).to eq(ids - del)
        expect(@users[1].unread_notifications.map{|n| n.post_id}).to eq(ids)
      end
    end
  end
end
