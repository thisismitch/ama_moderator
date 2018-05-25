require 'rails_helper'


describe 'with users and roles' do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, admin: true) }

  it 'shows sign-in page to non-logged-in user' do
    visit root_path
    expect(current_path).to eq(new_user_session_path)
  end

  it 'allows a logged-in user to view the event index page' do
    login(user)
    visit events_path
    expect(current_path).to eq(events_path)
  end

  it 'allows an admin user to view the users page' do
    login(admin)
    visit users_path
    expect(current_path).to eq(users_path)
  end

  it 'does not allow a normal user to view the users page' do
    login(user)
    visit users_path
    expect(current_path).to_not eq(users_path)
  end
end