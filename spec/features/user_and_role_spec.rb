require 'rails_helper'


describe 'with users and roles' do
  let(:normal_user) { FactoryGirl.create(:normal_user) }
  let(:admin_user) { FactoryGirl.create(:admin_user) }

  it 'shows sign-in page to non-logged-in user' do
    visit root_path
    expect(current_path).to eq(new_user_session_path)
  end

  it 'allows a logged-in user to view the event index page' do
    login(normal_user)
    visit events_path
    expect(current_path).to eq(events_path)
  end

  it 'allows an admin user to view the users page' do
    login(admin_user)
    visit users_path
    expect(current_path).to eq(users_path)
  end

  it 'does not allow a normal user to view the users page' do
    login(normal_user)
    visit users_path
    expect(current_path).to_not eq(users_path)
  end
end