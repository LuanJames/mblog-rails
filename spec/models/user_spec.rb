require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
  	subject { FactoryGirl.build :user }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:username) } 
    it { is_expected.to validate_presence_of(:password) }  
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it 'username' do
      subject.username = 'Test 2'
      is_expected.not_to be_valid 
    end
    it '#strip_whitespace' do
      u1 = FactoryGirl.build :user
      u2 = FactoryGirl.build :user
      u2.username = u1.username+' '
      u1.save
      u2.save
      expect(u2.errors.count).to eq(1)
    end
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

      context 'follow notification' do
        before do
          (1..2).each { |i| users[i].following << users[0] }
          users[0].make_followers_as_saw users[1].id
        end
        it '#make_followers_as_saw' do
          expect(Relationship.where(from_id: users[1].id, to_id: users[0].id, saw: true).count).to eq 1
        end

        it '#new_followers' do
          expect(users[0].new_followers).to eq [users[2]]
        end
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

  describe '.search' do
    let(:user1) { FactoryGirl.create :user, name: 'Luan James', username: 'CapJam' }
    let(:user2) { FactoryGirl.create :user, name: 'Luan Jam', username: 'LuanJames' }

    it 'return [] when empty string is passed' do
      expect(User.search '').to match_array []
    end

    it 'works by name' do
      expect(User.search 'james').to match_array [user1]
      expect(User.search 'luan').to match_array [user1, user2]
      expect(User.search 'Luan').to match_array [user1, user2]
      expect(User.search 'jam lua').to match_array [user1, user2]
      expect(User.search 'CapJam').to match_array [user1]
      expect(User.search 'Cap').to match_array []
    end


  end

end
