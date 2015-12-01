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
      event.scheduled_datetime = DateTime.now - 1

      expect(event).to be_closed
    end

    it 'future events are open' do
      event.scheduled_datetime = DateTime.tomorrow
      expect(event).not_to be_closed
    end
  end

  describe 'stats' do
    let(:admin_user) { FactoryGirl.create(:admin_user) }
    let(:event) { Event.create(name: 'Cool Event', user: admin_user) }

    describe '#vote_count' do
      it 'returns 0 for new events' do
        expect(event.vote_count).to eq 0
      end

      it 'count the total number of votes' do
        question = event.questions.new
        question.votes.new(user_id: 1, type_of: 'up')
        question.votes.new(user_id: 2, type_of: 'down')

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

        result = event.questioner_user_ids
        expect(result).to eq [1, 2]
      end
    end

    describe '#voter_user_ids' do
      it 'returns an empty array if no questions were asked' do
        expect(event.voter_user_ids).to eq []
      end

      it 'can create an array IDs of users who voted on a question' do
        question = event.questions.new
        question.votes.new(user_id: 1, type_of: :up)
        question.votes.new(user_id: 2, type_of: :up)
        question.votes.new(user_id: 3, type_of: :down)

        result = event.voter_user_ids
        expect(result).to eq [1, 2, 3]
      end

      it 'can create an array of IDs of a user who voted on more than one question' do
        question1 = event.questions.new
        question2 = event.questions.new

        question1.votes.new(user_id: 1, type_of: :up)
        question2.votes.new(user_id: 1, type_of: :down)

        result = event.voter_user_ids
        expect(result).to eq [1,1]
      end
    end

    describe '#participant_count' do  
      it 'returns 0 if there are no questions or votes' do
        expect(event.participant_count).to eq 0
      end

      it 'can sum unique participants who submitted a question or vote' do
        question1 = event.questions.new(user_id: 5, copy: 'i ask questions and vote?')
        question2 = event.questions.new(user_id: 10, copy: 'i only ask questions?')
        question2.votes.new(user_id: 5, type_of: 'up')

        result = event.participant_count
        expect(result).to eq 2
      end
    end
  end
end