# This will guess the User class
FactoryGirl.define do
  factory :game do
    score Random.rand(150..300)

    trait :with_handicap do
      score Random.rand(100..150)
      handicap Random.rand(10..60)
    end
  end
end
