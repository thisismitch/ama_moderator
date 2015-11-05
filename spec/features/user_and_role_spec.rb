require 'rails_helper'


describe 'with users and roles' do
  it 'allows a logged-in user to view the event index page' do
    user = FactoryGirl.create(:normal_user)
    login_as(user, :scope => :user)
    visit events_path
    expect(current_path).to eq(events_path)
  end
end