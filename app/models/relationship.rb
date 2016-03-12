class Relationship < ActiveRecord::Base
  belongs_to :from, :class_name => 'User', :foreign_key => 'from_id'
  belongs_to :to, :class_name => 'User', :foreign_key => 'to_id'

  validates :to_id, presence: true
  validates :from_id, presence: true
  validates_uniqueness_of :from_id, scope: :to_id

  validate :cannot_add_self


  def self.make_as_saw(ids, user)
    where('to_id = ? and id in (?)', user.id, ids).update_all(saw: true)
  end


  private
  def cannot_add_self
    errors.add(:base, 'You cannot add yourself as a relationship.') if from_id == to_id
  end
end
