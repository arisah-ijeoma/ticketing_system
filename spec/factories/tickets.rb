FactoryGirl.define do
  factory :ticket, class: Ticket do
    title 'First Ticket'
    description 'I love food'
    association(:user)
  end
end
