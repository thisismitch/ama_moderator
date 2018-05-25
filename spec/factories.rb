FactoryBot.define do
  factory :user do
    name 'Nancy Normal'
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'f4k3p455w0rd'
    admin false
    provider 'google_oauth2'
  end

  factory :event do
    user
    sequence(:name) { |n| "Event Name #{n}" }
  end
end