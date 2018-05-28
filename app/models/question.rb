class Question < ActiveRecord::Base
  validates :user_id, :event_id, presence: true
  validates :copy, presence: true, length: { minimum: 3 }

  belongs_to :user
  belongs_to :event
  has_many :votes, dependent: :destroy
  has_many :responses, dependent: :destroy

  scope :approved_anonymous, -> { where('anonymous_flag = false OR (anonymous_flag = true AND admin_approved_at IS NOT NULL)') }

  def upvotes
    votes.where('type_of LIKE ?', :up).count
  end

  def score
    self.upvotes
  end
end
