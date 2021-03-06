require 'rails_helper'

RSpec.describe Event do
  describe "manual status" do
    let(:event) { Event.new }

    it "considers a new event to be open" do
      expect(event).not_to be_closed
    end

    it "can be closed" do
      event.close

      expect(event).to be_closed
    end

    it "can be re-opened" do
      event.close
      event.open

      expect(event).not_to be_closed
    end
  end

  describe 'status' do
    let(:event) { Event.new }

    it 'past events are closed' do
      event.scheduled_at = DateTime.now - 1

      expect(event).to be_closed
    end

    it 'future events are open' do
      event.scheduled_at = DateTime.tomorrow
      expect(event).not_to be_closed
    end
  end

  describe 'stats' do
    let(:event) { Event.new }

    describe '#vote_count' do
      let(:question) { event.questions.new }

      it 'returns 0 for new events' do
        expect(event.vote_count).to eq 0
      end

      it 'count the total number of votes on a question' do
        vote = question.votes.new

        expect(event.vote_count).to eq 1
      end

      it 'count the total number of votes on all questions' do
        new_question = event.questions.new
        vote1 = question.votes.new
        vote2 = new_question.votes.new

        expect(event.vote_count).to eq 2
      end
    end

    describe '#questioner_user_ids' do
      it 'returns an empty array if no questions were asked' do
        expect(event.questioner_user_ids).to eq []
      end

      it 'can create an array IDs of users who asked questions' do
        event.questions.new(user_id: 1)
        event.questions.new(user_id: 2)

        expect(event.questioner_user_ids).to eq [1, 2]
      end
    end

    describe '#voter_user_ids' do
      it 'returns an empty array if no questions were asked' do
        expect(event.voter_user_ids).to eq []
      end

      it 'can create an array IDs of users who voted on a question' do
        question = event.questions.new
        question.votes.new(user_id: 1)
        question.votes.new(user_id: 2)

        expect(event.voter_user_ids).to eq [1, 2]
      end

      it 'can create an array of user IDs that voted on questions' do
        question1 = event.questions.new
        question2 = event.questions.new
        question1.votes.new(user_id: 1)
        question2.votes.new(user_id: 2)

        expect(event.voter_user_ids).to eq [1, 2]
      end
    end

    describe '#participant_count' do
      it 'returns 0 if there are no questions or votes' do
        expect(event.participant_count).to eq 0
      end

      it 'can sum unique participants who submitted a question or vote' do
        question1 = event.questions.new(user_id: 1)
        question2 = event.questions.new(user_id: 2)
        question2.votes.new(user_id: 2)

        expect(event.participant_count).to eq 2
      end
    end
  end
end
