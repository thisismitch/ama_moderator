require 'rails_helper'

describe "adding events" do
  include EventsHelper

  let(:admin) { FactoryBot.create(:user, admin: true) }
  let(:name) { 'AMA 10.31' }
  let(:description) { 'Ask me anything about Halloween' }
  let(:datetime) { DateTime.new(2015, 10, 31, 10, 30) }

  it "allows an admin user to create an event with name, datetime, description" do
    login(admin)
    visit new_event_path
    fill_in "Name", with: name
    fill_in "Description", with: description
    fill_in 'Date and Time', with: '2015-10-31 10:30'
    click_button("Create Event")
    visit events_path
    within('#event_table') do
      expect(page).to have_selector('.name', text: name)
      expect(page).to have_selector('.description', text: description)
      expect(page).to have_selector('.datetime', text: format_datetime(datetime))

      click_on(name)  # visit the event
    end

    # check that event show has event details - where do i put this?!??!
    expect(page).to have_selector('#event_name', text: name)
    expect(page).to have_selector('#event_description', text: description)
    expect(page).to have_selector('#event_datetime', text: format_datetime(datetime))
  end
end
