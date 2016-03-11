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
end
