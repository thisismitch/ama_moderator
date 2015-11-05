FactoryGirl.define do
  factory :admin_user, :class => :user do
    name 'Andrew Adminz'
    email 'adminz@gmail.com'
    password 'f4k3p455w0rd'
    admin true
    provider 'google_oauth2'
  end

  factory :normal_user, :class => :user do
    name 'Nancy Normal'
    email 'normal@gmail.com'
    password 'f4k3p455w0rd'
    admin false
    provider 'google_oauth2'
  end
end