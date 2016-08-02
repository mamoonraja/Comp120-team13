FactoryGirl.define do
  factory :user do
    email         "test@email.com"
    password      "XXXXXXXXX"
    first_name    "First"
    last_name     "Last"
    role          "Student"
  end

  factory :incident do
    description "I am idiot."
    location "tisch"
    severity "3"
    date "4/8"
    time "1:1:1"
  end
end
