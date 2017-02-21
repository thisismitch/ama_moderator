class VotesController < ApplicationController
  before_action :set_question_and_vote

  def upvote
    return if @vote

    @vote = @question.votes.create(user_id: current_user.id, type_of: 'up')
    redirect_to event_path(@question.event_id, anchor: "question_#{@question.id}"), notice: 'Question upvoted.'
  end

  private

  def set_question_and_vote
    @question = Question.find(params[:id])
    @vote = @question.votes.find_by(user_id: current_user.id)
  end
end
