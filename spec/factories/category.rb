# frozen_string_literal: true

FactoryBot.define do
  factory :category_a, class: Category do
    name 'Category A'
  end
  factory :category_b, class: Category do
    name 'Category B'
  end
  factory :category_c, class: Category do
    name 'Category C'
  end
  factory :category_d, class: Category do
    name 'Category D'
  end
  factory :trick, class: Category do
    name 'Trick'
  end
  factory :tick, class: Category do
    name 'Tick'
  end
  factory :track, class: Category do
    name 'Track'
  end
end
