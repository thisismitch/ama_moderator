require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:normal_user) { FactoryGirl.create(:normal_user) }
  let(:admin_user) { FactoryGirl.create(:admin_user) }

  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:admin_user] # If using Devise
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
    sign_in admin_user
  end

  it "creates an event" do
    post :create, event: {name: "Christmas", description: "Merry Xmas", scheduled_at: Date.parse('25/12/2015')}
    expect(response).to redirect_to(events_path)
    expect(assigns(:event).name).to eq("Christmas")
  end

  it "goes back to form on failure" do
    post :create, event: {name: ""}
    expect(response).to render_template(:new)
    expect(assigns(:event)).to be_present
  end
end
