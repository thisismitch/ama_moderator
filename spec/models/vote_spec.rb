require 'rails_helper'

RSpec.describe Vote do
  describe "modification" do
    let(:vote) { Vote.new }

    it 'can be an upvote' do
      vote.up
      expect(vote.type_of).to eq 'up'
    end

    it 'can be an downvote' do
      vote.down
      expect(vote.type_of).to eq 'down'
    end
  end
end