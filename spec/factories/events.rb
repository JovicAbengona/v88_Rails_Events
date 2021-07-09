FactoryBot.define do
  factory :event do
    user { nil }
    name { "MyString" }
    date { "2021-07-07" }
    city { "MyString" }
    state { "MyString" }
  end
end
