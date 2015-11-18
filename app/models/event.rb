class Event < ActiveRecord::Base
  validates :user_id, :name, presence: true
  has_many :questions, dependent: :destroy
  belongs_to :user

  def close
    self.update(closed: true)
  end

  def open
    self.update(closed: false)
  end

  # closed? overloaded to return true if event was manually closed, or if the scheduled time has been reached
  def closed?
    if self.scheduled_datetime.nil?
      self.closed   # manually closed?
    else
      DateTime.now > self.scheduled_datetime
    end
  end

  def vote_count
    self.questions.inject(0) { |result, question| result += question.votes.size }
  end

  # participant_count is the number of unique users who have submitted a question or a vote
  def participant_count
    participants = questioner_user_ids + voter_user_ids
    participants.uniq.size
  end

  def questioner_user_ids
    self.questions.map { |question| question.user_id }
  end

  def voter_user_ids
    user_ids = self.questions.map do |question|
      question.votes.map { |vote| vote.user_id }
    end
    user_ids.flatten
  end
end
