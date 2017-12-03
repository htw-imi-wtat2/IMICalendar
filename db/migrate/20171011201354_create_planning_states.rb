# frozen_string_literal: true

class CreatePlanningStates < ActiveRecord::Migration[5.1]
  def change
    create_table :planning_states do |t|
      t.references :event, foreign_key: true
      t.boolean :date_set
      t.boolean :room_booked
      t.boolean :announced
      t.text :notes

      t.timestamps
    end
  end
end
