class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_many :votes
  has_many :comments
end
