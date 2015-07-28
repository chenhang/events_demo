class Project < ActiveRecord::Base
  belongs_to :team
  has_many :accesses, dependent: :destroy
  has_many :users, through: :accesses
  has_many :events, as: :parentable

  validates :name, presence: true

end
