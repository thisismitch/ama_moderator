require 'rails_helper'

RSpec.describe Event do
  describe "manual status" do
    let(:event) { Event.new }
    it "considers a new event to be open" do
      expect(event.closed?).to be_falsy
    end

    it "can be closed" do
      event.close
      expect(event.closed?).to be_truthy
    end

    it "can be re-opened" do
      event.close
      event.open
      expect(event.closed?).to be false
    end
  end

  describe 'status' do
    let!(:event) { Event.new }
    
    it 'past events are closed' do
      event.scheduled_datetime = DateTime.now - 1
      expect(event.closed?).to be true
    end

    it 'future events are open' do
      event.scheduled_datetime = DateTime.tomorrow
      expect(event.closed?).to be false
    end
  end

  describe 'stats' do
    let(:admin_user) { FactoryGirl.create(:admin_user) }
    let(:event) { Event.create(name: 'Cool Event', user: admin_user) }

    describe '#vote_count' do
      it 'returns 0 for new events' do
        expect(event.vote_count).to eq(0)
      end

      it 'count the total number of votes' do
        question = event.questions.new(user_id: 1, copy: 'whats up doc?')
        question.votes.new(user_id: 5, type_of: 'up')
        question.votes.new(user_id: 10, type_of: 'down')
        expect(event.vote_count).to eq 2
      end
    end

    describe '#questioner_user_ids' do
      it 'returns an empty array if no questions were asked' do
        expect(event.questioner_user_ids).to eq []
      end

      it 'can create an array IDs of users who asked questions' do
        event.questions.new(user_id: 5, copy: 'i am normal user?')
        event.questions.new(user_id: 10, copy: 'i am admin user?')
        expect(event.questioner_user_ids).to eq [5, 10]
      end
    end

    describe '#voter_user_ids' do
      it 'returns an empty array if no questions were asked' do
        expect(event.voter_user_ids).to eq []
      end

      it 'can create an array IDs of users who voted on questions' do
        question = event.questions.create(user_id: 1, copy: 'whats up doc?')
        question.votes.new(user_id: 5, type_of: 'up')
        question.votes.new(user_id: 10, type_of: 'up')
        question.votes.new(user_id: 15, type_of: 'down')
        expect(event.voter_user_ids).to eq [5, 10, 15]
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
        expect(event.participant_count).to eq 2
      end
    end
  end
end