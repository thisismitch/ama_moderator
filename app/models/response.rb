class Response < ActiveRecord::Base
  validates :user_id, :question_id, presence: true
  validates :copy, presence: true, length: { minimum: 3 }

  belongs_to :user
  belongs_to :question

  scope :approved_anonymous, -> { where('anonymous_flag IS NULL OR anonymous_flag = false OR (anonymous_flag = true AND admin_approved_at IS NOT NULL)') }
end
