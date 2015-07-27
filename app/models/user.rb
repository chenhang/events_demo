class User < ActiveRecord::Base
  has_many :accesses, dependent: :destroy
  has_many :projects, through: :accesses
end
