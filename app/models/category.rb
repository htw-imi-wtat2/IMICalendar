# frozen_string_literal: true

# Represents a Category for an Event.
class Category < ApplicationRecord
  has_and_belongs_to_many :events
  validates :name, presence: true, length: { minimum: 1 }

  def self.names_alphabetically
    Category.all.order(:name).pluck(:name)
  end
end
