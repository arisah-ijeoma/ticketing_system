FactoryGirl.define do
  factory :message, class: Message do
    text 'I need your assistance on this'
    association(:ticket)
  end
end
