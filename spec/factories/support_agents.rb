FactoryGirl.define do
  factory :support_agent, class: SupportAgent do
    email { Faker::Internet.email }
    password 'password'
    first_name 'Support'
    last_name 'Agent'

    trait :admin do
      admin true
    end

    factory :admin_agent, traits: [:admin]
  end
end
