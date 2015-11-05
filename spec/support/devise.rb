include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do |config|
  config.after :each do
    Warden.test_reset!
  end
end

def login(user)
 login_as(user, :scope => :user)
end


# integration tests
RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
  :provider => 'twitter',
  :uid => '123545'
  
    })


omniauth_hash = { 'provider' => 'google_oauth2',
                  'uid' => '1',
                  'info' => {
                      'name' => 'Andrew Adminz',
                      'email' => 'adminz@gmail.com',
                  }
                }


OmniAuth.config.add_mock(:google, omniauth_hash)