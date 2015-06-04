class User < ActiveRecord::Base
  has_many :questions
  has_many :responses
  has_many :votes
  has_many :events
  belongs_to :role
  validates_uniqueness_of :email
end
