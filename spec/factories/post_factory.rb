FactoryGirl.define do
  factory :post do
    sequence :title do |n|
      "Title #{n}"
    end
    sequence :content do |n|
      "Content #{n}"
    end
  end
end
