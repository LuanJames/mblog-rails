require 'rails_helper'

RSpec.describe Relationship, type: :model do
  context 'validations' do
    subject { FactoryGirl.build :relationship }

    it { is_expected.to belong_to(:from).class_name('User').with_foreign_key('from_id') }  
    it { is_expected.to belong_to(:to).class_name('User').with_foreign_key('to_id') }  
    it { is_expected.to validate_presence_of(:from_id) }
    it { is_expected.to validate_presence_of(:to_id) } 
    it { is_expected.to validate_uniqueness_of(:from_id).scoped_to(:to_id) }

    it 'that user do not follow his self' do
      subject.from_id = 1
      subject.to_id = 1
      subject.valid?
      expect(subject.errors[:base].size).to eq(1)
      expect(subject.errors[:base]).to be_present
    end
  end
end
