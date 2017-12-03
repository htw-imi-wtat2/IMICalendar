# frozen_string_literal: true

# This will guess the User class
FactoryBot.define do
  factory :user do
    email 'someone@htw-berlin.de'
    password 'geheimgeheim'
    password_confirmation 'geheimgeheim'
  end
  # This will use the User class
  # Factories are validated, so it's not possible to create a user
  # without password like this
  # factory :user_without_password, class: User do
  #   email 'someone@htw-berlin.de'
  # end

end
