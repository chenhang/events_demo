class Account < ActiveRecord::Base
  has_many :users

  validates :name, presence: true

  def teams
    users.map {|user| user.team}
  end

end
