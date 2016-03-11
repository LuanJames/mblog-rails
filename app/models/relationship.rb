class Relationship < ActiveRecord::Base
  belongs_to :from, :class_name => 'User', :foreign_key => 'from_id'
  belongs_to :to, :class_name => 'User', :foreign_key => 'to_id'

  validates :to_id, presence: true
  validates :from_id, presence: true, uniqueness: { scope: :to_id }

  validate :cannot_add_self


  private
  def cannot_add_self
    errors.add(:base, 'You cannot add yourself as a relationship.') if from_id == to_id
  end
end
