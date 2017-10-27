# frozen_string_literal: true

# Represents a Category for an Event.
class Category < ApplicationRecord
  has_and_belongs_to_many :events

  def self.names_alphabetically
    Category.all.order(:name).pluck(:name)
  end
end
