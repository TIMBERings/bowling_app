# This will guess the User class
FactoryGirl.define do
  factory :frame do
    frame Random.rand(1..9)
    first Random.rand(0..10)
    association :game, factory: :game

    trait :strike do
      first 10
      second nil
    end

    trait :spare do
      first 8
      second 2
    end

    trait :split do
      first 8
      second nil
      split true
    end

    trait :open do
      first 7
      second 2
    end

    trait :twelfth do
      frame 12
    end

    trait :eleventh do
      frame 11
    end
  end
end
