FactoryGirl.define do
  factory :customer, class: Customer do
    email { Faker::Internet.email }
    password 'password'
    first_name 'Ije'
    last_name 'Oma'
  end
end
