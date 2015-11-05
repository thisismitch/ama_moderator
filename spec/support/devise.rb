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