class Project < ActiveRecord::Base
  belongs_to :team
  has_many :accesses, dependent: :destroy
  has_many :users, through: :accesses
  validates :name, presence: true
  validate :name_cannot_be_same_in_team

  def name_cannot_be_same_in_team
    if Project.where(name: self.name, team_id: self.team_id).exists?
      errors.add(:name ,"is duplicated in project's team")
    end
  end
end
