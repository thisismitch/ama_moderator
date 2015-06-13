class Event < ActiveRecord::Base
  validates :user_id, :name, presence: true
  has_many :questions
  belongs_to :user
end
