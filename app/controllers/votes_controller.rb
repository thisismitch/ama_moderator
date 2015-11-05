class VotesController < ApplicationController
  before_action :set_question_and_vote

  def upvote
    if @vote.nil?
      @vote = @question.votes.create(user_id: current_user.id, type_of: 'up')
      redirect_to event_path(@question.event_id, anchor: "question_#{@question.id}"), notice: 'Question upvoted.'
    elsif @vote.type_of == 'down'
      @vote.up
      redirect_to event_path(@question.event_id, anchor: "question_#{@question.id}"), notice: 'Question upvoted.'
    end
  end

  def downvote
    if @vote.nil?
      @vote = @question.votes.create(user_id: current_user.id, type_of: 'down')
      redirect_to event_path(@question.event_id, anchor: "question_#{@question.id}"), notice: 'Question downvoted.'
    elsif @vote.type_of == 'up'
      @vote.down
      redirect_to event_path(@question.event_id, anchor: "question_#{@question.id}"), notice: 'Question downvoted.'
    end
  end
  
  private

  def set_question_and_vote
    @question = Question.find(params[:id])
    @vote = @question.votes.find_by(user_id: current_user.id)
  end
end
