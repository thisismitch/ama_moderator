require 'rails_helper'
require 'helpers/select_datetime_helper'

describe "adding events" do
  include SelectDatetime

  let(:admin_user) { FactoryGirl.create(:admin_user) }

  it "allows a user to create an event with name, datetime, description" do
    login(admin_user)
    visit new_event_path
    fill_in "Name", with: "AMA 10.31"
    fill_in "Description", with: "Ask me anything about Halloween"
    select_date_and_time DateTime.new(2015, 10, 31, 18, 30), from: "event_scheduled_datetime"
    click_button("Create Event")
    visit events_path
    expect(page).to have_content("AMA 10.31")
    expect(page).to have_content("Halloween")
    expect(page).to have_content("2015-10-31")
  end
end