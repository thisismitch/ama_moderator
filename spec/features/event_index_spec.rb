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
    end
  end

  context 'when 1 event exists' do
    let!(:event) { FactoryGirl.create(:event) }
    it 'has event' do
      subject
      expect(page).to have_content(event.name)
    end
  end
end
