class Question < ActiveRecord::Base
  validates :user_id, :event_id, presence: true
  validates :copy, presence: true, length: { minimum: 3 }

  belongs_to :user
  belongs_to :event
  has_many :votes
  has_many :comments
end
