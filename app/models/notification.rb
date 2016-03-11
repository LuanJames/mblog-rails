class Notification < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :post, presence: true
  validates :user, presence: true
  validates_uniqueness_of :post_id, scope: :user_id

end
