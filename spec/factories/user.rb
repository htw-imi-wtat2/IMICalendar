# frozen_string_literal: true

# This will guess the User class
FactoryBot.define do
  factory :user do
    email 'someone@htw-berlin.de'
    password 'geheimgeheim'
    password_confirmation 'geheimgeheim'
  end
  # This will use the User class (Admin would have been guessed)
  factory :admin, class: User do
    email 'someone@htw-berlin.de'
    password 'geheimgeheim'
    password_confirmation 'geheimgeheim'
  end
end
