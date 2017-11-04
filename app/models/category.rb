# frozen_string_literal: true

# Represents a Category for an Event.
class Category < ApplicationRecord
  has_and_belongs_to_many :events
  validates :name, presence: true, length: { minimum: 1 }

  def self.names_alphabetically
    Category.all.order(:name).pluck(:name)
  end

  def self.combine(categories)
    main = categories.shift
    categories.each do |c|
      main.events << c.events
      c.destroy
    end
    main
  end
end
