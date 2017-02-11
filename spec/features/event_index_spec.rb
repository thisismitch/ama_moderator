require 'rails_helper'

describe 'events index' do
  subject { visit events_path }

  let(:user) { FactoryGirl.create(:user) }
  before do
    login(user)
  end

  context 'when 0 events exist' do
    it 'displays no events message' do
      subject
      expect(page).to have_content('There are no events yet. Ask an admin to create one')
      expect(page).to_not have_selector('.event-item')
    end
  end

  context 'when 1 event exists' do
    let!(:event) { FactoryGirl.create(:event) }
    it 'displays event' do
      subject
      expect(page).to have_content(event.name)
      expect(page).to have_selector('.event-item', count: 1)
    end
  end

  context 'when 20 events exist' do
    before do
      20.times { |n| FactoryGirl.create(:event) }
    end

    it 'displays 20 events' do
      subject
      expect(page).to have_selector('.event-item', count: 20)
    end
  end

  context 'when > 20 events exist' do
    let!(:old_event) { FactoryGirl.create(:event) }
    before do
      20.times { |n| FactoryGirl.create(:event) }
    end

    it 'displays 20 most recent events' do
      subject
      expect(page).to have_selector('.event-item', count: 20)
      expect(page).to_not have_content(old_event.name)
    end
  end
end
