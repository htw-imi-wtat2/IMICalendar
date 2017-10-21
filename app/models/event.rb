class Event < ApplicationRecord

  has_one :planning_state, dependent: :destroy

  accepts_nested_attributes_for :planning_state

  def date
    if start_date
      start_date.strftime("%d.%m.%Y")
    else
      "TBD"
    end
  end

end
