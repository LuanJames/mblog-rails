class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  validates :username, presence: true, uniqueness: {:case_sensitive => false}

  has_many :relationships, foreign_key: 'from_id'
  has_many :following, through: :relationships, source: :to

  before_validation :strip_whitespace

  def followers
    User.joins('INNER JOIN relationships ON relationships.to_id = ' + id.to_s).distinct.to_a
  end

  def new_followers
    User.where('id in (?)', Relationship.where('to_id = ? and saw = false', id).select(:from_id)).to_a
    # User.joins('INNER JOIN relationships ON relationships.to_id = ' + id.to_s).where('relationships.saw = false').distinct.to_a
  end

  def make_followers_as_saw(ids)
    Relationship.where('to_id = ? and from_id in (?)', id, ids).update_all(saw: true)
  end

  private
    def strip_whitespace
      self.username = self.username.strip unless self.username.nil?
    end
end
