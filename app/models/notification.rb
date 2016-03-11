class Notification < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :post, presence: true
  validates :user, presence: true
  validates_uniqueness_of :post_id, scope: :user_id


  def self.make_as_read(ids, user)
    where('user_id = ? and id in (?)', user.id, ids).update_all(read: true)
  end

  def self.make_as_read_by_post_id(ids, user)
    where('user_id = ? and post_id in (?)', user.id, ids).update_all(read: true)
  end
end
