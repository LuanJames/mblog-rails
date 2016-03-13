require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the HomeHelper. For example:
#
# describe HomeHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe '#time' do
    let(:post) { FactoryGirl.build :post }
    it 'second' do
      post.created_at = Time.now - 2.day
      post.updated_at = Time.now - 33.seconds

      expect(helper.time(post)).to eq '33 ' + I18n.t('view.abr.second')
    end

    it 'minutes' do
      post.created_at = Time.now - 2.day
      post.updated_at = Time.now - 41.minutes

      expect(helper.time(post)).to eq '41 ' + I18n.t('view.abr.minute')

    end

    it 'hours' do
      post.created_at = Time.now - 2.day
      post.updated_at = Time.now - 12.hours

      expect(helper.time(post)).to eq '12 ' + I18n.t('view.abr.hour')

    end
  end

  describe '#avatar_url' do
    let(:user) { FactoryGirl.create :user }

    it 'returns the avatar image with a image default' do
      default_url = "#{root_url}images/profile.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      expect(helper.avatar_url(user)).to eq("http://gravatar.com/avatar/#{gravatar_id}.png?s=128&d=mm")
    end
  end
end
