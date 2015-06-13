class VotesController < ApplicationController
  before_action :set_question

  def upvote
    # Need to implement updates
    @vote = @question.votes.create(user_id: current_user.id, type_of: 'up')
    redirect_to :back, notice: 'Question upvoted.'
  end

  def downvote
    # Need to implement updates
    @vote = @question.votes.create(user_id: current_user.id, type_of: 'down')
    redirect_to :back, notice: 'Question downvoted.'
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end
end
