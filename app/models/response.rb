class Response < ActiveRecord::Base
  validates :user_id, :question_id, presence: true
  validates :copy, presence: true, length: { minimum: 3 }

  belongs_to :user
  belongs_to :question
end
