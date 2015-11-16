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
    describe 'questions' do
      let(:event) { Event.create }

      it 'new event has no questions' do
        expect(event.question_count).to eq(0)
      end

      it 'can count its questions' do
        event.questions.new
        expect(event.question_count).to eq(1)
      end
    end

    xdescribe 'people' do
      it 'can sum participants (submitted questions, comments, or vote)' do
      end
    end

    xdescribe 'votes' do
      it 'can sum the votes of the current user' do
      end
    end
  end
end