require 'rails_helper'

RSpec.describe Event do
  describe "initialization" do
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
      event.reopen
      expect(event.closed?).to be false
    end
  end
end