class Project < ActiveRecord::Base
  has_many :accesses, dependent: destroy
  has_many :users, through: :accesses
end
