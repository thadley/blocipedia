FactoryGirl.define do
  factory :user do
    username "d.adams"
    sequence(:email) { "person#{rand(10000).to_s}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    confirmed_at Time.now
  end
end