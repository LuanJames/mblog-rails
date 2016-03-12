require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validations' do
    subject { FactoryGirl.build :post }

    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to belong_to(:user) }
  end
end
