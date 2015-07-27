class Team < ActiveRecord::Base
  has_many :users, dependent: :destroy
  has_many :projects, dependent: :destroy

  validates :name, {presence: true, uniqueness: true}
end
