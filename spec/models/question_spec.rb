require 'rails_helper'

describe Question do
  let(:question) { Question.create!(user_id: 1, event_id: 1, copy: 'Hello world?') }

  describe '#upvotes' do
    it 'new questions have 0 upvotes' do
      result = question.upvotes
      expect(result).to eq 0
    end

    it 'can count 1 upvotes' do
      vote = question.votes.new
      vote.up

      result = question.upvotes
      expect(result).to eq 1
    end
  end

  describe '#score' do
    it 'new questions have 0 score' do
      result = question.score
      expect(result).to eq 0
    end

    it 'question with multiple upvotes have a score' do
      upvote1 = question.votes.new(user_id: 1)
      upvote1.up
      upvote2 = question.votes.new(user_id: 2)
      upvote2.up

      expect(question.score).to eq 2
    end
  end
end
