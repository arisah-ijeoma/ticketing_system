FactoryGirl.define do
  factory :ticket, class: Ticket do
    title 'First Ticket'
    description 'I love food'
    status 'Pending'
    association(:customer)
    association(:support_agent)
  end
end
