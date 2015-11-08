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

  def closed?
    if self.scheduled_datetime.nil?
      self.closed   # manually closed?
    else
      DateTime.now > self.scheduled_datetime
    end
  end

  def vote_count
  	sum = 0
  	self.questions.each do |question|
  		sum += question.votes.count
  	end
  	sum
  end

  def participant_count
  	participants = []
  	self.questions.each do |question|
  		participants << question.user_id
  		question.votes.each do |vote|
  			participants << vote.user_id
  		end
  	end
  	participants.uniq.count
  end


end
