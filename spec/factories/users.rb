FactoryGirl.define do
  factory :user, class: User do
    email { Faker::Internet.email }
    password 'password'
    first_name 'Ije'
    last_name 'Oma'

    trait :admin do
      admin true
    end

    factory :admin_agent, traits: [:admin]
  end

  factory :support_agent, parent: :user, class: SupportAgent do
    email { Faker::Internet.email }
    password 'password'
    first_name 'Support'
    last_name 'Agent'
  end

  factory :customer, parent: :user, class: Customer do
    email { Faker::Internet.email }
    password 'password'
    first_name 'Custo'
    last_name 'Mer'
  end
end
