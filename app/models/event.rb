class Event < ActiveRecord::Base
  validates :user_id, :name, presence: true
  has_many :questions, dependent: :destroy
  belongs_to :user

  def close
    update(closed: true)
  end

  def open
    update(closed: false)
  end

  # closed? overloaded to return true if event was manually closed, or if the scheduled time has been reached
  def closed?
    if scheduled_datetime.present?
      DateTime.now > scheduled_datetime
    else
      closed   # manually closed?
    end
  end

  def vote_count
    questions.inject(0) { |result, question| result += question.votes.size }
  end

  def participants
    (questioner_user_ids + voter_user_ids).uniq
  end

  # participant_count is the number of unique users who have submitted a question or a vote
  def participant_count
    participants.count
  end

  def questioner_user_ids
    questions.map { |question| question.user_id }
  end

  def voter_user_ids
    questions.inject([]) do |result, question|
      result += question.votes.map(&:user_id)
    end
  end
end
