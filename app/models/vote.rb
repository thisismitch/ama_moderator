class Vote < ActiveRecord::Base
	validates_uniqueness_of :user_id, scope: :question_id

  belongs_to :user
  belongs_to :question

  def up
    self.update(type_of: :up)
  end
end
