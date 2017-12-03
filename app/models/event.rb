# frozen_string_literal: true

class Event < ApplicationRecord
  has_one :planning_state, dependent: :destroy
  has_and_belongs_to_many :categories
  accepts_nested_attributes_for :planning_state

  def date
    if start_date
      start_date.strftime('%d.%m.%Y')
    else
      'TBD'
    end
  end
end
