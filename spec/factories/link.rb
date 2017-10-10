FactoryGirl.define do
  factory :link do
    link FFaker::Internet.http_url
    company
  end
end
