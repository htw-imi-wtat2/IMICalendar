# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  before :each do
    @e1 = Event.create(title: 'Event 1',
                       start_date: DateTime.new(2018, 2, 2, 10, 0),
                       end_date: DateTime.new(2018, 2, 2, 17, 0),
                       location: 'H001',
                       description: 'The description of the event no 1')

    @e2 = Event.create(title: 'Event 2',
                       start_date: DateTime.new(2018, 2, 2, 10, 0),
                       end_date: DateTime.new(2018, 2, 2, 17, 0),
                       location: 'H001',
                       description: 'The description of the event no 2')
    @e3 = Event.create(title: 'Event 3',
                       start_date: DateTime.new(2018, 2, 2, 10, 0),
                       end_date: DateTime.new(2018, 2, 2, 17, 0),
                       location: 'H01',
                       description: 'The description of the event no 2')
    @c1 = Category.create(name: 'Category 1')
    @c2 = Category.create(name: 'Category 2')
    @c3 = Category.create(name: 'Category 3')
    @e1.categories << @c1
    @e2.categories << @c2
    @e3.categories << @c3
  end

  it 'deletes obsolete Category' do
    expect { Category.combine([@c1, @c2]) }.to change { Category.count }.by(-1)
  end

  it 'two can be combined' do
    Category.combine([@c1, @c2])
    expect(@c1.events.count).to eq 2
    @e2.reload
    expect(@e2.categories).to eq [@c1]
  end

  it 'deletes obsolete Categories' do
    expect { Category.combine([@c1, @c2, @c3]) }.to change { Category.count }.by(-2)
  end

  it 'three can be combined' do
    Category.combine([@c1, @c2, @c3])
    expect(@c1.events.count).to eq 3
    @e2.reload
    @e3.reload
    expect(@e2.categories).to eq [@c1]
    expect(@e3.categories).to eq [@c1]
  end

  it 'returns main category' do
    main = Category.combine([@c1, @c2, @c3])
    expect(main).to eq @c1
  end
end
