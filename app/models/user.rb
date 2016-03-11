class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :relationships, foreign_key: 'from_id'
  has_many :following, through: :relationships, source: :to

  def followers
    User.joins('INNER JOIN relationships ON relationships.to_id = ' + id.to_s).distinct.to_a
  end

  def unread_notifications
    Notification.where(user_id: id, read:false).to_a
  end

  def read_notifications=(ids)
    Notification.where('user_id = ? and id in (?)', id, ids).update_all(read: true)
  end
end
