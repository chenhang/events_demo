class User < ActiveRecord::Base
  belongs_to :team
  belongs_to :account
  has_many :accesses, dependent: :destroy
  has_many :projects, through: :accesses
  has_many :todos, foreign_key: "doer_id"
  has_many :events

  validates :name, presence: true

end
