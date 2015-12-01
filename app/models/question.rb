class Question < ActiveRecord::Base
  validates :user_id, :event_id, presence: true
  validates :copy, presence: true, length: { minimum: 3 }

  belongs_to :user
  belongs_to :event
  has_many :votes, dependent: :destroy
  has_many :responses, dependent: :destroy

  def upvotes
    votes.where('type_of LIKE ?', :up).count
  end

  def downvotes
    votes.where('type_of LIKE ?', :down).count
  end

  def score
    self.upvotes - self.downvotes
  end
end
