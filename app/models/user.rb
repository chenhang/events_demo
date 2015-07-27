class User < ActiveRecord::Base
  belongs_to :team
  has_many :accesses, dependent: :destroy
  has_many :projects, through: :accesses

  validates :name, presence: true
  validate :name_cannot_be_same_in_team

  def name_cannot_be_same_in_team
    if User.where(name: self.name, team_id: self.team_id).exists?
      errors.add(:name ,"is duplicated in user's team")
    end
  end
end
