class Post < ActiveRecord::Base
  belongs_to :user

  after_create :create_notifications

  validates :user, presence: true
  validates :content, presence: true


  private
  def create_notifications
    user.followers.each do |u|
      Notification.create(user: u, post_id: id)
    end
  end
end
